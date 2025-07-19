status-containers:
	podman stats -i 1

# clean-containers:
# 	podman rm -af

podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 podman_network

podman-load-images:
	podman load < ./deployment/images/dv0vd-socks4_1.0.4.tar
	podman load < ./deployment/images/dv0vd-socks5_1.0.10.tar
	podman load < ./deployment/images/dv0vd-https-proxy_1.0.0.tar
	podman load < ./deployment/images/mongo_7.0.16.tar
	podman load < ./deployment/images/nginx_1.27.3.tar
	podman load < ./deployment/images/node_20.18.1-bookworm.tar
	podman load < ./deployment/images/postgres_15.10-bookworm.tar

schedule-midnight-reboot:
	shutdown -r 0:00

logs-auth:
	journalctl -u ssh
