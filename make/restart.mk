restart-containers:
	- $(MAKE) stop-containers
	- $(MAKE) start-containers

restart-containers-proxy:
	- $(MAKE) stop-containers-proxy
	- $(MAKE) start-containers-proxy

restart-containers-gateway:
	- $(MAKE) stop-containers-gateway
	- $(MAKE) start-containers-gateway

restart-socks4: stop-socks4 start-socks4

restart-socks5: stop-socks5 start-socks5

restart-https-proxy: stop-https-proxy start-https-proxy

restart-outline: stop-outline start-outline

restart-xray-vless-reality: stop-xray-vless-reality start-xray-vless-reality

restart-xray-vless-reality-gateway: stop-xray-vless-reality-gateway start-xray-vless-reality-gateway

restart-xray-vless-reality-whitelist-bypass: stop-xray-vless-reality-whitelist-bypass start-xray-vless-reality-whitelist-bypass

restart-pihole: stop-pihole start-pihole

restart-pihole-gateway: stop-pihole start-pihole-gateway

restart-doh-server: stop-doh-server start-doh-server

restart-doh-server-gateway: stop-doh-server start-doh-server-gateway

restart-nginx: stop-nginx start-nginx

restart-nginx-gateway: stop-nginx start-nginx-gateway

restart-nginx-proxy: stop-nginx start-nginx-proxy

restart-db:
	- $(MAKE) stop-mongo-demo
	- $(MAKE) stop-postgres-demo
	- $(MAKE) start-mongo-demo
	- $(MAKE) start-postgres-demo

restart-mongo-demo: stop-mongo-demo start-mongo-demo

restart-postgres-demo: stop-postgres-demo start-postgres-demo

restart-postgres-synapse: stop-postgres-synapse start-postgres-synapse

restart-demo: stop-demo start-demo restart-nginx

restart-timers: stop-timers start-timers restart-nginx

restart-skillnotes: stop-skillnotes start-skillnotes restart-nginx

restart-todo-manager: stop-todo-manager start-todo-manager restart-nginx

restart-fail2ban: 
	systemctl restart fail2ban

restart-synapse: stop-synapse start-synapse restart-nginx

restart-coturn: stop-coturn start-coturn

restart-ntfy: stop-ntfy start-ntfy

restart-livekit: stop-livekit start-livekit restart-nginx

restart-livekit-redis: stop-livekit-redis start-livekit-redis

restart-matrix-rtc: stop-matrix-rtc start-matrix-rtc restart-nginx

restart-email: stop-email start-email

restart-rustdesk: stop-rustdesk start-rustdesk

restart-mtproto: stop-mtproto start-mtproto

restart-whitelist-bypass: stop-whitelist-bypass start-whitelist-bypass

restart-sip: stop-sip start-sip

restart-open-webui: stop-open-webui start-open-webui
