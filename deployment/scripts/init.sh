#!/bin/bash
set -e # stop script on any error
source ./deployment/scripts/init_common.sh


load_env
set_timezone
install_packages
configure_git
configure_dns
configure_ssh_main
configure_podman
configure_rclone
configure_nginx_main
configure_email
finish
