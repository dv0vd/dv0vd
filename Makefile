include .env

.DEFAULT_GOAL := help
.ONESHELL:
MAKEFLAGS += --no-print-directory

SOCKS5_IMAGE_NAME = dv0vd/socks5
SOCKS5_IMAGE_TAG = 1.0.0

start-containers:
	@-$(MAKE) start-socks5
	@-$(MAKE) start-socks4

stop-containers:
	@-podman stop -a

restart-containers:
	@-$(MAKE) stop-containers
	@-$(MAKE) podman-cleanup
	@-$(MAKE) podman-create-network
	@-$(MAKE) start-containers

status-containers:
	@- podman stats

start-socks4:
	@-podman run \
		-d \
		--name socks4 \
		--network podman_network \
		-p 60030:1080 \
		--restart unless-stopped \
		--sysctl net.ipv4.ip_forward=1 \
		--memory=128M \
		--cpus=0.25 \
		wernight/dante:latest

stop-socks4:
	@-podman stop socks4
	@-podman rm socks4

restart-socks4:
	@-$(MAKE) stop-socks4
	@-$(MAKE) start-socks4

build-socks5:
	@-$(MAKE) podman-cleanup
	@-podman build \
		-t $(SOCKS5_IMAGE_NAME):$(SOCKS5_IMAGE_TAG) . \
		-f ./deployment/containers/socks5.containerfile \
		--build-arg SOCKS5_USERNAME=$(SOCKS5_USERNAME) \
		--build-arg SOCKS5_PASSWORD=$(SOCKS5_PASSWORD)
	@-podman save socks5 > ./deployment/images/$(SOCKS5_IMAGE_NAME)_$(SOCKS5_IMAGE_TAG).tar

start-socks5:
	@-podman run \
		-d \
		--name socks5 \
		--network podman_network \
		-p 60010:1080 \
		--sysctl net.ipv4.ip_forward=1 \
		-e PROXY_USER=$(SOCKS5_USERNAME) \
		-e PROXY_PASSWORD=$(SOCKS5_PASSWORD) \
		--restart unless-stopped \
		--memory=128M \
		--cpus=0.25 \
		socks5

stop-socks5:
	@-podman stop socks5
	@-podman rm socks5

restart-socks5:
	@-$(MAKE) stop-socks5
	@-$(MAKE) start-socks5

stop-email:
	@-podman stop email
	@-podman rm email

restart-email:
	@-$(MAKE) stop-email
	@-$(MAKE) start-email

fail2ban-status-ssh:
	@-fail2ban-client status sshd

fail2ban-unban-all:
	@-fail2ban-client unban --all

podman-cleanup:
	@-podman system prune --all -f
	@-podman load < /root/dv0vd.xyz/deployment/images/xkuma-socks5_latest.tar
	@-podman load < /root/dv0vd.xyz/deployment/images/wernight-dante_latest.tar
	@-podman load < /root/dv0vd.xyz/deployment/images/debian_bookworm.tar
	@-podman load < /root/dv0vd.xyz/deployment/images/$(SOCKS5_IMAGE_NAME)_$(SOCKS5_IMAGE_TAG).tar

podman-create-network:
	@podman network create --ipv6 podman_network

schedule-midnight-reboot:
	@-shutdown -r 0:00

help:
	@echo start-containers'                            '—' 'start' 'all' 'containers
	@echo stop-containers'                            '—' 'stop' 'all' 'containers
	@echo restart-containers'                            '—' 'restart' 'all' 'containers
	@echo issue-cert' 'name=client_name'            '—' 'issue' 'OpenVPN' 'client' 'certificate
	@echo build-socks5'                            '—' 'build' 'socks5' 'server
	@echo start-socks5'                            '—' 'start' 'socks5' 'server
	@echo stop-socks5'                            '—' 'stop' 'socks5' 'server
	@echo restart-socks5'                            '—' 'restart' 'socks5' 'server
	@echo fail2ban-ssh'                            '—' 'ssh' 'blocked' 'ips
	@echo podman-cleanup'                            '—' 'podman' 'cleaning
	@echo podman-create-network'                            '—' 'podman' 'network' 'creating' 'with' 'ipv6' 'support
	@echo schedule-midnight-reboot'                            '—' 'reboot' 'server' 'at' 'midnight

