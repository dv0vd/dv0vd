#!/bin/bash
set -e # stop script on any error
source ./deployment/scripts/init_common.sh



load_env
set_timezone
install_packages
configure_git
configure_dns
configure_ssh
configure_podman_gateway
configure_nginx_gateway
finish_gateway
