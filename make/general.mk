# clean-containers:
# 	podman rm -af

schedule-midnight-reboot:
	shutdown -r 0:00

clear-logs:
	journalctl --vacuum-time=1d

# nginx-create-basic-auth:
# 	htpasswd -cb deployment/configs/nginx/.htpasswd $(NGINX_BASIC_AUTH_USERNAME) $(NGINX_BASIC_AUTH_PASSWORD)