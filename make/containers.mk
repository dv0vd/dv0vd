start-containers:
	- chattr -i /etc/resolv.conf
	- echo "nameserver 127.0.0.1" > /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- chattr +i /etc/resolv.conf
	- $(MAKE) start-pihole
	- $(MAKE) start-email
	- $(MAKE) start-open-webui
	- $(MAKE) start-db
	- $(MAKE) start-livekit-redis
	- $(MAKE) start-ntfy
	- $(MAKE) start-sip
	- $(MAKE) start-rustdesk
	- $(MAKE) start-coturn
	- $(MAKE) start-livekit
	- $(MAKE) start-matrix-rtc
	- $(MAKE) start-synapse
# 	- $(MAKE) start-demo
	- $(MAKE) start-nginx

start-containers-proxy:
	- chattr -i /etc/resolv.conf
	- echo "nameserver 127.0.0.1" > /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- chattr +i /etc/resolv.conf
	- $(MAKE) start-pihole
	- $(MAKE) start-xray-vless-reality
	- $(MAKE) start-doh-server
	- $(MAKE) start-nginx-proxy

start-containers-gateway:
	- chattr -i /etc/resolv.conf
	- echo "nameserver 127.0.0.1" > /etc/resolv.conf
	- echo "nameserver ${DNS_RU}" >> /etc/resolv.conf
	- echo "nameserver 77.88.8.8" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- chattr +i /etc/resolv.conf
	- $(MAKE) start-pihole
	- $(MAKE) start-doh-server-gateway
	- $(MAKE) start-whitelist-bypass
# 	- $(MAKE) start-xray-vless-reality-gateway
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
	- $(MAKE) stop-pihole

stop-containers-gateway:
	- $(MAKE) stop-nginx
	- $(MAKE) stop-xray-vless-reality-whitelist-bypass
# 	- $(MAKE) stop-xray-vless-reality-gateway
	- $(MAKE) stop-whitelist-bypass
	- $(MAKE) stop-doh-server
	- $(MAKE) stop-pihole

stop-containers-proxy:
	- $(MAKE) stop-nginx
	- $(MAKE) stop-doh-server
	- $(MAKE) stop-xray-vless-reality
	- $(MAKE) stop-pihole