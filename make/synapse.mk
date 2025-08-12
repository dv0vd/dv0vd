synapse-init:
	chmod 777 -R deployment/configs/synapse
	- podman run \
	--name synapse \
	-v ./deployment/data/synapse/data:/data \
	-v ./deployment/configs/synapse:/config \
	-e SYNAPSE_SERVER_NAME=${SYNAPSE_SERVER_NAME} \
	-e SYNAPSE_REPORT_STATS=no \
	-e SYNAPSE_CONFIG_DIR=/config \
	--network podman_network \
	docker.io/matrixdotorg/synapse:v1.135.0 generate

synapse-create-user:
	podman exec -it synapse bash -c 'register_new_matrix_user -c /config/homeserver.yaml'