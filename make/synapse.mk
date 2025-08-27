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
	- chmod +r deployment/configs/synapse/signing.key
	- chmod 777 deployment/data/synapse/data

synapse-create-user:
	podman exec -it synapse bash -c 'register_new_matrix_user -c /config/homeserver.yaml'

synapse-vacuum-clean:
	podman exec -it postgres-synapse sh -c 'psql -U ${SYNAPSE_DB_USERNAME} -d ${SYNAPSE_DB_NAME} -c "VACUUM FULL;"'

synapse-backup-database:
	- cp ./deployment/data/postgres-synapse/backups/1.dump ./deployment/data/postgres-synapse/backups/2.dump
	- rm ./deployment/data/postgres-synapse/backups/1.dump
	- cp ./deployment/data/postgres-synapse/backups/0.dump ./deployment/data/postgres-synapse/backups/1.dump
	podman exec -it postgres-synapse sh -c 'pg_dump -U ${SYNAPSE_DB_USERNAME} -v -Fc --exclude-table-data e2e_one_time_keys_json ${SYNAPSE_DB_NAME} > /backups/0.dump'
	- rm ./deployment/data/postgres-synapse/backups/2.dump

synapse-restore-database:
	podman exec -it postgres-synapse sh -c 'pg_restore -U ${SYNAPSE_DB_USERNAME} -v -d ${SYNAPSE_DB_NAME} < /backups/0.dump'

synapse-backup-to-storage-vps:
	- rclone sync -v '/root/dv0vd.xyz/deployment/data/postgres-synapse/backups' 'vps-storage-bg-encrypted:/root/dv0vd.xyz-backup/_data/postgres-synapse'
	- rclone sync -v '/root/dv0vd.xyz/deployment/data/synapse/data/media_store' 'vps-storage-bg-encrypted:/root/dv0vd.xyz-backup/_data/synapse'

synapse-restore-from-storage-vps:
	- rclone sync -v 'vps-storage-bg-encrypted:/root/dv0vd.xyz-backup/_data/postgres-synapse' '/root/dv0vd.xyz/deployment/data/postgres-synapse/restored_backups'
	- rclone sync -v 'vps-storage-bg-encrypted:/root/dv0vd.xyz-backup/_data/synapse' '/root/dv0vd.xyz/deployment/data/synapse/restored_backups'
