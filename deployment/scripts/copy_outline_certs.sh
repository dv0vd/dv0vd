#!/bin/bash
set -e # stop script on any error

set -a
. ./.env
set +a

PROXY_NAME=""
for entry in ${PROXIES:-}; do
  p="${entry%%=*}"
  ip="${entry#*=}"
  if [ "${ip}" = "${PUBLIC_IP}" ]; then
    PROXY_NAME="${p}"
    break
  fi
done

CERT_DIR="./deployment/data/letsencrypt/data/live/${PROXY_NAME}.${BASE_URL}"

cp -Lf "${CERT_DIR}/fullchain.pem" ./deployment/configs/outline/outline.crt
cp -Lf "${CERT_DIR}/privkey.pem" ./deployment/configs/outline/outline.key
chmod 644 ./deployment/configs/outline/outline.crt ./deployment/configs/outline/outline.key
