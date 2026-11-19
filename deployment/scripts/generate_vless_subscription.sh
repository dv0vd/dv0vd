#!/bin/bash
set -e # stop script on any error

set -a
. ./.env
set +a

# `:` — встроенная команда-ноуп (аналог `true`): не делает ничего, всегда возвращает код 0;
# `> file` — редирект stdout: __создаёт файл, если его нет, или усечает до нуля байт, если уже существует__.
: > ./deployment/data/nginx/vless_subscription.txt

for item in ${PROXIES:-}; do
  name="${item%%=*}"
  echo "vless://${XRAY_VLESS_REALITY_UUID}@${XRAY_URL}.${name}.${BASE_URL}:443?encryption=none&flow=xtls-rprx-vision&type=tcp&security=reality&sni=${BASE_URL}&fp=firefox&pbk=${XRAY_VLESS_REALITY_PUBLIC_KEY}&sid=${XRAY_VLESS_REALITY_USER1}" >> ./deployment/data/nginx/vless_subscription.txt
done
