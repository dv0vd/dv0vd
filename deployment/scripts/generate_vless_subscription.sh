#!/bin/bash
set -e # stop script on any error

set -a
. ./.env
set +a

echo "" > ./deployment/data/nginx/vless_subscription.txt

for item in ${PROXIES:-}; do
  name="${item%%=*}"
  echo "vless://${XRAY_VLESS_REALITY_UUID}@${name}.${BASE_URL}:${XRAY_VLESS_REALITY_PORT}?encryption=none&flow=xtls-rprx-vision&type=tcp&security=reality&sni=${BASE_URL}&fp=randomized&pbk=${XRAY_VLESS_REALITY_PUBLIC_KEY}&sid=${XRAY_VLESS_REALITY_USER1}" >> ./deployment/data/nginx/vless_subscription.txt
done
