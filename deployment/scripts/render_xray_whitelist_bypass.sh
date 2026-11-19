#!/bin/bash
set -e # stop on any error

set -a
. ./.env
set +a

NAMES=""
add_name() {
  [ -n "$1" ] || return 0
  case " $NAMES " in
    *" $1 "*) ;;
    *) NAMES="$NAMES $1" ;;
  esac
}

add_name "${PROXY_MAIN_URL:-}"
for entry in ${PROXIES:-}; do
  add_name "${entry%%=*}"
done

OUTBOUNDS='[{"tag": "blackhole", "protocol": "blackhole", "settings": {}}]'

for name in $NAMES; do
  # Префикс node- обязателен: selector/subjectSelector в Xray матчатся по ПРЕФИКСУ.
  # Без него тег ноды "d" попадает и в "direct", и leastPing выбирает direct (он быстрее).
  OUTBOUNDS=$(jq -c \
    --arg tag "node-$name" \
    --arg name "$name" \
    --arg address "$XRAY_URL.$name.$BASE_URL" \
    --argjson port 443 \
    --arg uuid "$XRAY_VLESS_REALITY_UUID" \
    --arg server_name "$BASE_URL" \
    --arg pbk "$XRAY_VLESS_REALITY_PUBLIC_KEY" \
    --arg sid "$XRAY_VLESS_REALITY_USER0" \
    '. + [{
      "tag": $tag,
      "protocol": "vless",
      "settings": {
        "vnext": [{
          "address": $address,
          "port": $port,
          "users": [{
            "id": $uuid,
            "encryption": "none",
            "flow": "xtls-rprx-vision"
          }]
        }]
      },
      "streamSettings": {
        "network": "raw",
        "security": "reality",
        "realitySettings": {
          "serverName": $server_name,
          "fingerprint": "random",
          "publicKey": $pbk,
          "shortId": $sid
        }
      }
    }]' <<<"$OUTBOUNDS")
done

OUTBOUNDS=$(jq -c '. + [{"tag": "direct", "protocol": "freedom", "settings": {}}]' <<<"$OUTBOUNDS")

envsubst < ./deployment/configs/xray-vless-reality/whitelist_bypass_env.json | jq -c \
  --argjson outbounds "$OUTBOUNDS" \
  '($outbounds | map(select(.protocol == "vless") | .tag)) as $proxies
   | .outbounds = $outbounds
   | .routing.balancers[0].selector = $proxies
   | .routing.balancers[0].fallbackTag = "blackhole"
   | .routing.rules += [{"type": "field", "network": "tcp,udp", "outboundTag": "blackhole"}]
   | .burstObservatory.subjectSelector = $proxies' \
  > ./deployment/configs/xray-vless-reality/whitelist_bypass.json
