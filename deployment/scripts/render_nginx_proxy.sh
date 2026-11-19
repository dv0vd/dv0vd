#!/bin/bash
set -e # stop script on any error

set -a
. ./.env
set +a

if [ "${PUBLIC_IP}" = "${PROXY_RU_IP}" ]; then
  PROXY_NAME="ru"
else
  PROXY_NAME=""
  for entry in ${PROXIES:-}; do
    p="${entry%%=*}"
    ip="${entry#*=}"
    if [ "${ip}" = "${PUBLIC_IP}" ]; then
      PROXY_NAME="${p}"
      break
    fi
  done
fi

PROXY_NAME="${PROXY_NAME}" envsubst '$PROXY_NAME $BASE_URL' < ./deployment/configs/nginx/conf.d/proxy_env.conf > ./deployment/configs/nginx/conf.d/proxy.conf
PROXY_NAME="${PROXY_NAME}" XRAY_URL="${XRAY_URL}" envsubst '$XRAY_URL $PROXY_NAME $BASE_URL $XRAY_VLESS_REALITY_PORT' < ./deployment/configs/nginx/conf.d/stream_env.conf > ./deployment/configs/nginx/conf.d/stream.conf

