podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 --disable-dns --interface-name podman-main podman_network

podman-create-whitelist-bypass-network:
	podman network create --subnet 10.89.10.0/24 --disable-dns --interface-name podman-wlb whitelist_bypass_network

podman-pull-images:
	podman pull docker.io/pihole/pihole:2025.08.0
	podman pull docker.io/nineseconds/mtg:2.2.8
	podman pull docker.io/dv0vd/socks5:1.1.1
	podman pull docker.io/dv0vd/socks4:1.1.3
	podman pull docker.io/dv0vd/https-proxy:1.2.0
	podman pull docker.io/teddysun/xray:25.10.15
	podman pull quay.io/outline/shadowbox:v1.12.3
	podman pull docker.io/nginx:1.27.3
	podman pull docker.io/certbot/certbot:v5.3.1

	podman save docker.io/teddysun/xray:25.10.15 > ./deployment/images/teddysun-xray.tar
	podman save docker.io/nginx:1.27.3 > ./deployment/images/nginx.tar
	podman save docker.io/certbot/certbot:v5.3.1 > ./deployment/images/certbot.tar
	podman save docker.io/pihole/pihole:2025.08.0 > ./deployment/images/pihole.tar
	podman save docker.io/nineseconds/mtg:2.2.8 > ./deployment/images/nineseconds-mtg.tar
	podman save docker.io/dv0vd/socks5:1.1.1 > ./deployment/images/dv0vd-socks5.tar
	podman save docker.io/dv0vd/socks4:1.1.3 > ./deployment/images/dv0vd-socks4.tar
	podman save docker.io/dv0vd/https-proxy:1.2.0 > ./deployment/images/dv0vd-https-proxy.tar
	podman save quay.io/outline/shadowbox:v1.12.3 > ./deployment/images/outline-shadowbox.tar

podman-load-images:
	podman load < ./deployment/images/dv0vd-https-proxy.tar
	podman load < ./deployment/images/dv0vd-socks4.tar
	podman load < ./deployment/images/dv0vd-socks5.tar
	podman load < ./deployment/images/nginx.tar
	podman load < ./deployment/images/outline-shadowbox.tar
	podman load < ./deployment/images/pihole.tar
	podman load < ./deployment/images/teddysun-xray.tar
	podman load < ./deployment/images/nineseconds-mtg.tar
	podman load < ./deployment/images/certbot.tar

podman-info:
	podman ps -w 1

podman-stats:
	podman stats -i 1

podman-resources:
	systemctl status podman-group.slice