# clean-containers:
# 	podman rm -af

schedule-midnight-reboot:
	shutdown -r 0:00



# nginx-create-basic-auth:
# 	htpasswd -cb deployment/configs/nginx/.htpasswd $(NGINX_BASIC_AUTH_USERNAME) $(NGINX_BASIC_AUTH_PASSWORD)