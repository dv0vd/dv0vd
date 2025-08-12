include .env

.DEFAULT_GOAL := help
.ONESHELL:
MAKEFLAGS += --no-print-directory

include ./make/help.mk
include ./make/logs.mk
include ./make/restart.mk
include ./make/start.mk
include ./make/stop.mk
include ./make/general.mk
include ./make/enter.mk
include ./make/demo.mk
include ./make/synapse.mk

# stop-email:
# 	- podman stop email
# 	- podman rm email

# restart-email:
# 	- $(MAKE) stop-email
# 	- $(MAKE) start-email

# fail2ban-status-ssh:
# 	fail2ban-client status sshd

# fail2ban-unban-all:
# 	@-fail2ban-client unban --all

