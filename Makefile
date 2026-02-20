include .env

.DEFAULT_GOAL := help
.ONESHELL:
MAKEFLAGS += --no-print-directory

PUBLIC_IP := $(shell ip -4 addr show | awk '/inet/ && !/127.0.0.1/ {print $$2}' | cut -d/ -f1 | head -n1)
export PUBLIC_IP

include ./make/help.mk
include ./make/logs.mk
include ./make/restart.mk
include ./make/start.mk
include ./make/stop.mk
include ./make/enter.mk
include ./make/demo.mk
include ./make/synapse.mk
include ./make/fail2ban.mk
include ./make/podman.mk
include ./make/hooks.mk
include ./make/outline.mk
include ./make/common.mk
include ./make/iptables.mk
include ./make/certbot.mk
