# clean-containers:
# 	podman rm -af

schedule-midnight-reboot:
	shutdown -r 0:00

postgres-vacuum-clean:
	podman exec -it postgres-synapse sh -c 'psql -U ${SYNAPSE_DB_USERNAME} -d ${SYNAPSE_DB_NAME} -c "VACUUM FULL;"'
# podman run postgres-synapse sh -c 'psql -U ${SYNAPSE_DB_NAME} -d <database> -c "VACUUM;'

# nginx-create-basic-auth:
# 	htpasswd -cb deployment/configs/nginx/.htpasswd $(NGINX_BASIC_AUTH_USERNAME) $(NGINX_BASIC_AUTH_PASSWORD)