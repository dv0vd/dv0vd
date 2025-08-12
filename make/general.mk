status-containers:
	podman stats -i 1

status-fail2ban:
	fail2ban-client status
	fail2ban-client status sshd
	fail2ban-client status nginx-http-auth
	fail2ban-client status nginx-limit-req
	fail2ban-client status nginx-botsearch
	fail2ban-client status nginx-bad-request
	fail2ban-client status danted

# clean-containers:
# 	podman rm -af

podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 podman_network

podman-load-images:
	podman load < ./deployment/images/dv0vd-socks4_1.0.5.tar
	podman load < ./deployment/images/dv0vd-socks5_1.0.11.tar
	podman load < ./deployment/images/dv0vd-https-proxy_1.0.5.tar
	podman load < ./deployment/images/mongo_7.0.16.tar
	podman load < ./deployment/images/nginx_1.27.3.tar
	podman load < ./deployment/images/node_20.18.1-bookworm.tar
	podman load < ./deployment/images/postgres_15.10-bookworm.tar
	podman load < ./deployment/images/synapse_1.135.0.tar
	podman load < ./deployment/images/element_1.11.108.tar
# podman load < ./deployment/images/synapse-admin_0.11.1.tar

schedule-midnight-reboot:
	shutdown -r 0:00

clear-logs:
	journalctl --vacuum-time=1d

# nginx-create-basic-auth:
# 	htpasswd -cb deployment/configs/nginx/.htpasswd $(NGINX_BASIC_AUTH_USERNAME) $(NGINX_BASIC_AUTH_PASSWORD)