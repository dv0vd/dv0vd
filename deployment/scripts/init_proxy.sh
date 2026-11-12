#!/bin/bash
set -e # stop script on any error
source ./deployment/scripts/init_common.sh



load_env
set_timezone
install_packages
configure_git
configure_dns
configure_ssh
configure_podman
configure_nginx_proxy
configure_outline
generate_mtproto_proxy_config
finish