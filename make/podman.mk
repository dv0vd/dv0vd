podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 --disable-dns podman_network

podman-create-whitelist-bypass-network:
	podman network create --subnet 10.89.10.0/24 whitelist_bypass_network

podman-pull-images:
	podman pull docker.io/certbot/docker.io/nginx:1.27.3
	podman pull docker.io/certbot/docker.io/teddysun/xray:25.10.15
	podman pull docker.io/certbot/certbot:v5.3.1
	podman pull docker.io/satishweb/doh-server:v2.3.10-alpine
	podman pull ghcr.io/kulikov0/whitelist-bypass-bot:v0.4.4
	podman save docker.io/certbot/docker.io/nginx:1.27.3 > ./deployment/images/nginx_1.27.3.tar
	podman save docker.io/certbot/docker.io/teddysun/xray:25.10.15 > ./deployment/images/teddysun_xray-25.10.15.tar
	podman save docker.io/certbot/certbot:v5.3.1 > ./deployment/images/certbot_5.3.1.tar
	podman save docker.io/satishweb/doh-server:v2.3.10-alpine > ./deployment/images/satishweb-doh-server_v2.3.10-alpine.tar
	podman save ghcr.io/kulikov0/whitelist-bypass-bot:v0.4.4 > ./deployment/images/kulikov0-whitelist-bypass-bot_v0.4.4.tar

podman-load-images:
	podman load < ./deployment/images/nginx_1.27.3.tar
	podman load < ./deployment/images/teddysun_xray-25.10.15.tar
	podman load < ./deployment/images/certbot_5.3.1.tar
	podman load < ./deployment/images/satishweb-doh-server_v2.3.10-alpine.tar
	podman load < ./deployment/images/kulikov0-whitelist-bypass-bot_v0.4.4.tar

podman-info:
	podman ps -w 1

podman-stats:
	podman stats -i 1

podman-resources:
	systemctl status podman-group.slice