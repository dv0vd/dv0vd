podman-pull-images:
	podman pull ghcr.io/docker-mailserver/docker-mailserver:15.1.0
	podman pull ghcr.io/open-webui/open-webui:v0.13.3-slim
# 	podman pull docker.io/mongo:7.0.16
	podman pull docker.io/postgres:15.14-alpine
	podman pull docker.io/redis:8.4.0-alpine
	podman pull docker.io/binwiederhier/ntfy:v2.17
	podman pull docker.io/andrius/asterisk:22.8-cert3_debian-trixie
	podman pull docker.io/rustdesk/rustdesk-server:1.1.15
	podman pull docker.io/coturn/coturn:4.7.0
	podman pull docker.io/certbot/certbot:v5.3.1
	podman pull docker.io/nginx:1.27.3
	podman pull docker.io/livekit/livekit-server:v1.9.11
	podman pull ghcr.io/element-hq/lk-jwt-service:0.4.1
	podman pull docker.io/matrixdotorg/synapse:v1.135.0
# 	podman pull docker.io/dv0vd/demo-timers:1.0.5
# 	podman pull docker.io/dv0vd/demo-skillnotes:1.0.11
# 	podman pull docker.io/dv0vd/demo-todo-manager:1.1.1

	podman save ghcr.io/docker-mailserver/docker-mailserver:15.1.0 > ./deployment/images/docker-mailserver.tar
	podman save ghcr.io/open-webui/open-webui:v0.13.3-slim > ./deployment/images/open-webui.tar
# 	podman save docker.io/mongo:7.0.16 > ./deployment/images/mongo.tar
	podman save docker.io/postgres:15.14-alpine > ./deployment/images/postgres.tar
	podman save docker.io/redis:8.4.0-alpine > ./deployment/images/redis.tar
	podman save docker.io/binwiederhier/ntfy:v2.17 > ./deployment/images/ntfy.tar
	podman save docker.io/andrius/asterisk:22.8-cert3_debian-trixie > ./deployment/images/sip.tar
	podman save docker.io/rustdesk/rustdesk-server:1.1.15 > ./deployment/images/rustdesk-server.tar
	podman save docker.io/coturn/coturn:4.7.0 > ./deployment/images/coturn.tar
	podman save docker.io/certbot/certbot:v5.3.1 > ./deployment/images/certbot.tar
	podman save docker.io/nginx:1.27.3 > ./deployment/images/nginx.tar
	podman save docker.io/livekit/livekit-server:v1.9.11 > ./deployment/images/livekit-server.tar
	podman save ghcr.io/element-hq/lk-jwt-service:0.4.1 > ./deployment/images/matrix-rtc.tar
	podman save docker.io/matrixdotorg/synapse:v1.135.0 > ./deployment/images/synapse.tar
# 	podman save docker.io/dv0vd/demo-timers:1.0.5 > ./deployment/images/demo-timers.tar
# 	podman save docker.io/dv0vd/demo-skillnotes:1.0.11 > ./deployment/images/demo-skillnotes.tar
# 	podman save docker.io/dv0vd/demo-todo-manager:1.1.1 > ./deployment/images/demo-todo-manager.tar

podman-pull-images-proxy:
	podman pull docker.io/pihole/pihole:2025.08.0
	podman pull docker.io/nineseconds/mtg:2.2.8
	podman pull docker.io/dv0vd/socks5:1.1.1
	podman pull docker.io/dv0vd/socks4:1.1.3
	podman pull docker.io/dv0vd/https-proxy:1.2.0
	podman pull docker.io/teddysun/xray:25.10.15
	podman pull quay.io/outline/shadowbox:v1.12.3
	podman pull docker.io/nginx:1.27.3
	podman pull docker.io/certbot/certbot:v5.3.1
	podman pull docker.io/satishweb/doh-server:v2.3.10-alpine

	podman save docker.io/teddysun/xray:25.10.15 > ./deployment/images/teddysun-xray.tar
	podman save docker.io/nginx:1.27.3 > ./deployment/images/nginx.tar
	podman save docker.io/certbot/certbot:v5.3.1 > ./deployment/images/certbot.tar
	podman save docker.io/pihole/pihole:2025.08.0 > ./deployment/images/pihole.tar
	podman save docker.io/nineseconds/mtg:2.2.8 > ./deployment/images/nineseconds-mtg.tar
	podman save docker.io/dv0vd/socks5:1.1.1 > ./deployment/images/dv0vd-socks5.tar
	podman save docker.io/dv0vd/socks4:1.1.3 > ./deployment/images/dv0vd-socks4.tar
	podman save docker.io/dv0vd/https-proxy:1.2.0 > ./deployment/images/dv0vd-https-proxy.tar
	podman save quay.io/outline/shadowbox:v1.12.3 > ./deployment/images/outline-shadowbox.tar
	podman save docker.io/satishweb/doh-server:v2.3.10-alpine > ./deployment/images/satishweb-doh-server.tar

podman-pull-images-gateway:
	podman pull docker.io/nginx:1.27.3
	podman pull docker.io/teddysun/xray:25.10.15
	podman pull docker.io/certbot/certbot:v5.3.1
	podman pull docker.io/satishweb/doh-server:v2.3.10-alpine
	podman pull ghcr.io/kulikov0/whitelist-bypass-bot:v0.5.1
	podman pull docker.io/pihole/pihole:2025.08.0
	podman save docker.io/nginx:1.27.3 > ./deployment/images/nginx.tar
	podman save docker.io/teddysun/xray:25.10.15 > ./deployment/images/teddysun-xray.tar
	podman save docker.io/certbot/certbot:v5.3.1 > ./deployment/images/certbot.tar
	podman save docker.io/satishweb/doh-server:v2.3.10-alpine > ./deployment/images/satishweb-doh-server.tar
	podman save ghcr.io/kulikov0/whitelist-bypass-bot:v0.5.1 > ./deployment/images/kulikov0-whitelist-bypass-bot.tar
	podman save docker.io/pihole/pihole:2025.08.0 > ./deployment/images/pihole.tar

podman-load-images:
	podman load < ./deployment/images/docker-mailserver.tar
	podman load < ./deployment/images/open-webui.tar
# 	podman load < ./deployment/images/mongo.tar
	podman load < ./deployment/images/postgres.tar
	podman load < ./deployment/images/redis.tar
	podman load < ./deployment/images/ntfy.tar
	podman load < ./deployment/images/sip.tar
	podman load < ./deployment/images/rustdesk-server.tar
	podman load < ./deployment/images/coturn.tar
	podman load < ./deployment/images/certbot.tar
	podman load < ./deployment/images/nginx.tar
	podman load < ./deployment/images/livekit-server.tar
	podman load < ./deployment/images/matrix-rtc.tar
	podman load < ./deployment/images/synapse.tar
# 	podman load < ./deployment/images/demo-timers.tar
# 	podman load < ./deployment/images/demo-skillnotes.tar
# 	podman load < ./deployment/images/demo-todo-manager.tar

podman-load-images-proxy:
	podman load < ./deployment/images/dv0vd-https-proxy.tar
	podman load < ./deployment/images/dv0vd-socks4.tar
	podman load < ./deployment/images/dv0vd-socks5.tar
	podman load < ./deployment/images/nginx.tar
	podman load < ./deployment/images/outline-shadowbox.tar
	podman load < ./deployment/images/pihole.tar
	podman load < ./deployment/images/teddysun-xray.tar
	podman load < ./deployment/images/nineseconds-mtg.tar
	podman load < ./deployment/images/certbot.tar
	podman load < ./deployment/images/satishweb-doh-server.tar

podman-load-images-gateway:
	podman load < ./deployment/images/nginx.tar
	podman load < ./deployment/images/teddysun-xray.tar
	podman load < ./deployment/images/certbot.tar
	podman load < ./deployment/images/satishweb-doh-server.tar
	podman load < ./deployment/images/kulikov0-whitelist-bypass-bot.tar