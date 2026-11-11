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

PROXY_NAME="${PROXY_NAME}" envsubst '$PROXY_NAME $BASE_URL' < ./deployment/configs/nginx/conf.d/proxy_env.conf > ./deployment/configs/nginx/conf.d/proxy.conf
