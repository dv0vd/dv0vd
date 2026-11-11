podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 --disable-dns --interface-name podman-main podman_network

podman-create-whitelist-bypass-network:
	podman network create --subnet 10.89.10.0/24 --disable-dns --interface-name podman-wlb whitelist_bypass_network

podman-pull-images:
	podman pull docker.io/nginx:1.27.3
	podman pull docker.io/teddysun/xray:25.10.15
	podman pull docker.io/certbot/certbot:v5.3.1
	podman pull docker.io/satishweb/doh-server:v2.3.10-alpine
	podman pull ghcr.io/kulikov0/whitelist-bypass-bot:v0.5.1
	podman save docker.io/nginx:1.27.3 > ./deployment/images/nginx.tar
	podman save docker.io/teddysun/xray:25.10.15 > ./deployment/images/teddysun-xray.tar
	podman save docker.io/certbot/certbot:v5.3.1 > ./deployment/images/certbot.tar
	podman save docker.io/satishweb/doh-server:v2.3.10-alpine > ./deployment/images/satishweb-doh-server.tar
	podman save ghcr.io/kulikov0/whitelist-bypass-bot:v0.5.1 > ./deployment/images/kulikov0-whitelist-bypass-bot.tar

podman-load-images:
	podman load < ./deployment/images/nginx.tar
	podman load < ./deployment/images/teddysun-xray.tar
	podman load < ./deployment/images/certbot.tar
	podman load < ./deployment/images/satishweb-doh-server.tar
	podman load < ./deployment/images/kulikov0-whitelist-bypass-bot.tar

podman-info:
	podman ps -w 1

podman-stats:
	podman stats -i 1

podman-resources:
	systemctl status podman-group.slice