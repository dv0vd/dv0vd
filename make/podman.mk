podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 podman_network --subnet 10.100.0.0/16 --gateway 10.100.0.1

podman-load-images:
	podman load < ./deployment/images/coturn_4.7.0.tar
	podman load < ./deployment/images/dv0vd-demo-skillnotes_1.0.10.tar
	podman load < ./deployment/images/dv0vd-demo-timers_1.0.5.tar
	podman load < ./deployment/images/dv0vd-demo-todo-manager_1.1.1.tar
	podman load < ./deployment/images/dv0vd-https-proxy_1.2.0.tar
	podman load < ./deployment/images/dv0vd-socks4_1.1.3.tar
	podman load < ./deployment/images/dv0vd-socks5_1.1.1.tar
	podman load < ./deployment/images/mongo_7.0.16.tar
	podman load < ./deployment/images/nginx_1.27.3.tar
	podman load < ./deployment/images/outline-shadowbox_v1.12.3.tar
	podman load < ./deployment/images/pihole_2025.08.0.tar
	podman load < ./deployment/images/postgres_15.14-alpine.tar
	podman load < ./deployment/images/synapse_1.135.0.tar
	podman load < ./deployment/images/teddysun_xray-25.10.15.tar
	podman load < ./deployment/images/satishweb-doh-server_v2.3.10-alpine.tar
	podman load < ./deployment/images/certbot_5.3.1.tar
	podman load < ./deployment/images/binwiederhier-ntfy_2.17.tar
	podman load < ./deployment/images/livekit-server_1.9.11.tar
	podman load < ./deployment/images/redis_8.4.0-alpine.tar
	podman load < ./deployment/images/element-hq-lk-jwt-service_0.4.1.tar

podman-info:
	podman ps -w 1

podman-stats:
	podman stats -i 1

podman-resources:
	systemctl status podman-group.slice
