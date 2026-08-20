stop-containers:
	- $(MAKE) stop-nginx
	- $(MAKE) stop-pihole
	- $(MAKE) stop-socks4
	- $(MAKE) stop-socks5
	- $(MAKE) stop-mtproto
	@if [ "${PUBLIC_IP}" = "${VPS_RU}" ]; then \
		$(MAKE) stop-whitelist-bypass; \
		$(MAKE) stop-xray-vless-reality-whitelist-bypass; \
	fi
	- $(MAKE) stop-https-proxy
	- $(MAKE) stop-outline

stop-socks4:
	- podman stop socks4
	- podman rm socks4

stop-socks5:
	- podman stop socks5
	- podman rm socks5

stop-https-proxy:
	- podman stop https-proxy
	- podman rm https-proxy

stop-outline:
	- podman stop outline
	- podman rm outline

stop-xray-vless-reality-whitelist-bypass:
	- podman stop xray-vless-reality-whitelist-bypass
	- podman rm xray-vless-reality-whitelist-bypass

stop-xray-vless-reality:
	- podman stop xray-vless-reality
	- podman rm xray-vless-reality

stop-xray-vless-reality-whitelist-bypass:
	- podman stop xray-vless-reality-whitelist-bypass
	- podman rm xray-vless-reality-whitelist-bypass

stop-nginx:
	- podman stop nginx
	- podman rm nginx

stop-db:
	- $(MAKE) stop-mongo-demo
	- $(MAKE) stop-postgres-demo
	- $(MAKE) stop-postgres-synapse

stop-mongo-demo:
	- podman stop mongo-demo
	- podman rm mongo-demo

stop-postgres-demo:
	- podman stop postgres-demo
	- podman rm postgres-demo

stop-postgres-synapse:
	- podman stop postgres-synapse
	- podman rm postgres-synapse

stop-demo:
	$(MAKE) stop-timers
	$(MAKE) stop-skillnotes
	$(MAKE) stop-todo-manager

stop-timers:
	- podman stop demo-timers
	- podman rm demo-timers

stop-skillnotes:
	- podman stop demo-skillnotes
	- podman rm demo-skillnotes

stop-todo-manager:
	- podman stop demo-todo-manager
	- podman rm demo-todo-manager

stop-fail2ban:
	systemctl disable fail2ban
	systemctl stop fail2ban

stop-synapse:
	- podman stop synapse
	- podman rm synapse

stop-coturn:
	- podman stop coturn
	- podman rm coturn

stop-pihole:
	- podman stop pihole
	- podman rm pihole

stop-doh-server:
	- podman stop doh-server
	- podman rm doh-server

stop-ntfy:
	- podman stop ntfy
	- podman rm ntfy

stop-livekit:
	- podman stop livekit
	- podman rm livekit

stop-livekit-redis:
	- podman stop livekit-redis
	- podman rm livekit-redis

stop-matrix-rtc:
	- podman stop matrix-rtc
	- podman rm matrix-rtc

stop-email:
	- podman stop email
	- podman rm email

stop-rustdesk:
	- podman stop rustdesk-id
	- podman stop rustdesk-relay
	- podman rm rustdesk-id
	- podman rm rustdesk-relay

stop-mtproto:
	- podman stop mtproto
	- podman rm mtproto

stop-whitelist-bypass:
	- podman stop whitelist-bypass
	- podman rm whitelist-bypass

stop-sip:
	- podman stop sip
	- podman rm sip
