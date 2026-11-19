#!/bin/bash

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
