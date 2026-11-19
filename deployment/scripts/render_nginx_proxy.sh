#!/bin/bash
set -e # stop script on any error

set -a
. ./.env
XRAY_URL="${XRAY_URL:-xray}"
. ./deployment/scripts/proxy_name.sh
set +a

PROXY_NAME="${PROXY_NAME}" envsubst '$PROXY_NAME $BASE_URL' < ./deployment/configs/nginx/conf.d/proxy_env.conf > ./deployment/configs/nginx/conf.d/proxy.conf
PROXY_NAME="${PROXY_NAME}" XRAY_URL="${XRAY_URL}" envsubst '$XRAY_URL $PROXY_NAME $BASE_URL $XRAY_VLESS_REALITY_PORT' < ./deployment/configs/nginx/conf.d/stream_env.conf > ./deployment/configs/nginx/conf.d/stream.conf

