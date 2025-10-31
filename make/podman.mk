podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 podman_network

podman-load-images:
	podman load < ./deployment/images/dv0vd-https-proxy_1.2.0.tar
	podman load < ./deployment/images/dv0vd-socks4_1.1.3.tar
	podman load < ./deployment/images/dv0vd-socks5_1.1.1.tar
	podman load < ./deployment/images/nginx_1.27.3.tar
	podman load < ./deployment/images/outline-shadowbox_v1.12.3.tar
	podman load < ./deployment/images/pihole_2025.08.0.tar

podman-info:
	podman ps -w 1

podman-stats:
	podman stats -i 1

podman-resources:
	systemctl status podman-group.slice
