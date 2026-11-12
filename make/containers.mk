start-containers:
	- echo "nameserver ${DNS_1}" > /etc/resolv.conf
	- echo "nameserver ${DNS_2}" >> /etc/resolv.conf
	- echo "nameserver ${DNS_3}" >> /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- $(MAKE) email-backup-to-storage-vps
	- $(MAKE) start-email
	- $(MAKE) start-open-webui
	- $(MAKE) start-db
	- $(MAKE) start-livekit-redis
	- $(MAKE) start-ntfy
	- $(MAKE) start-sip
	- $(MAKE) rustdesk-backup-to-storage-vps
	- $(MAKE) start-rustdesk
	- $(MAKE) synapse-vacuum-clean
	- $(MAKE) synapse-backup-database
	- $(MAKE) synapse-backup-to-storage-vps
	- $(MAKE) start-coturn
	- $(MAKE) start-livekit
	- $(MAKE) start-matrix-rtc
	- $(MAKE) start-synapse
# 	- $(MAKE) start-demo
	- $(MAKE) start-nginx

start-containers-proxy:
	- echo "nameserver ${DNS_1}" > /etc/resolv.conf
	- echo "nameserver ${DNS_2}" >> /etc/resolv.conf
	- echo "nameserver ${DNS_3}" >> /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- $(MAKE) start-pihole
	- $(MAKE) start-mtproto
	- $(MAKE) start-socks5
	- $(MAKE) start-socks4
	- $(MAKE) start-https-proxy
	- $(MAKE) start-xray-vless-reality
	- $(MAKE) start-outline
	- $(MAKE) start-doh-server
	- $(MAKE) start-nginx-proxy

start-containers-gateway:
	- echo "nameserver ${DNS_RU}" > /etc/resolv.conf
	- echo "nameserver 77.88.8.8" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- $(MAKE) start-doh-server-gateway
	- $(MAKE) start-whitelist-bypass
	- $(MAKE) start-xray-vless-reality-gateway
	- $(MAKE) start-xray-vless-reality-whitelist-bypass
	- $(MAKE) start-nginx-gateway

stop-containers:
	- $(MAKE) stop-nginx
# 	- $(MAKE) stop-demo
	- $(MAKE) stop-synapse
	- $(MAKE) stop-matrix-rtc
	- $(MAKE) stop-livekit
	- $(MAKE) stop-coturn
	- $(MAKE) stop-rustdesk
	- $(MAKE) stop-sip
	- $(MAKE) stop-ntfy
	- $(MAKE) stop-livekit-redis
	- $(MAKE) stop-db
	- $(MAKE) stop-open-webui
	- $(MAKE) stop-email

stop-containers-gateway:
	- $(MAKE) stop-nginx
	- $(MAKE) stop-xray-vless-reality-whitelist-bypass
	- $(MAKE) stop-xray-vless-reality-gateway
	- $(MAKE) stop-whitelist-bypass
	- $(MAKE) stop-doh-server

stop-containers-proxy:
	- $(MAKE) stop-nginx
	- $(MAKE) stop-doh-server
	- $(MAKE) stop-outline
	- $(MAKE) stop-xray-vless-reality
	- $(MAKE) stop-https-proxy
	- $(MAKE) stop-socks4
	- $(MAKE) stop-socks5
	- $(MAKE) stop-mtproto
	- $(MAKE) stop-pihole