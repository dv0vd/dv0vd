podman-pull-images:
	podman pull ghcr.io/docker-mailserver/docker-mailserver:15.1.0
	podman pull ghcr.io/open-webui/open-webui:v0.11.3
	podman pull docker.io/mongo:7.0.16
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
	podman pull docker.io/dv0vd/demo-timers:1.0.5
	podman pull docker.io/dv0vd/demo-skillnotes:1.0.11
	podman pull docker.io/dv0vd/demo-todo-manager:1.1.1

	podman save ghcr.io/docker-mailserver/docker-mailserver:15.1.0 > ./deployment/images/docker-mailserver.tar
	podman save ghcr.io/open-webui/open-webui:v0.11.3 > ./deployment/images/open-webui.tar
	podman save docker.io/mongo:7.0.16 > ./deployment/images/mongo.tar
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
	podman save docker.io/dv0vd/demo-timers:1.0.5 > ./deployment/images/demo-timers.tar
	podman save docker.io/dv0vd/demo-skillnotes:1.0.11 > ./deployment/images/demo-skillnotes.tar
	podman save docker.io/dv0vd/demo-todo-manager:1.1.1 > ./deployment/images/demo-todo-manager.tar

podman-load-images:
	podman load < ./deployment/images/docker-mailserver.tar
	podman load < ./deployment/images/open-webui.tar
	podman load < ./deployment/images/mongo.tar
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
	podman load < ./deployment/images/demo-timers.tar
	podman load < ./deployment/images/demo-skillnotes.tar
	podman load < ./deployment/images/demo-todo-manager.tar

