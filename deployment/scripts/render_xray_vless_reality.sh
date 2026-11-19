#!/bin/bash
set -e # stop on any error

set -a
. ./.env
XRAY_URL="${XRAY_URL:-xray}"
. ./deployment/scripts/proxy_name.sh
set +a

envsubst < ./deployment/configs/xray-vless-reality/xray_env.json > ./deployment/configs/xray-vless-reality/xray.json
