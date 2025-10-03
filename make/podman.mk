podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 podman_network

podman-load-images:
	podman load < ./deployment/images/dv0vd-socks4_1.1.3.tar
	podman load < ./deployment/images/dv0vd-socks5_1.1.1.tar
	podman load < ./deployment/images/dv0vd-https-proxy_1.2.0.tar
	podman load < ./deployment/images/mongo_7.0.16.tar
	podman load < ./deployment/images/nginx_1.27.3.tar
	podman load < ./deployment/images/node_20.18.1-bookworm.tar
	podman load < ./deployment/images/node_24.5.0-alpine.tar
	podman load < ./deployment/images/postgres_15.14-alpine.tar
	podman load < ./deployment/images/synapse_1.135.0.tar
	podman load < ./deployment/images/coturn_4.7.0.tar
	podman load < ./deployment/images/pihole_2025.08.0.tar
	podman load < ./deployment/images/dv0vd-demo-timers_1.0.5.tar
	podman load < ./deployment/images/dv0vd-demo-skillnotes_1.0.8.tar

podman-info:
	podman ps -w 1

podman-stats:
	podman stats -i 1

podman-resources:
	systemctl status podman-group.slice
