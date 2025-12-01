start-containers:
	- echo "nameserver ${DNS1}" > /etc/resolv.conf
	- echo "nameserver ${DNS2}" >> /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- $(MAKE) start-db
	- $(MAKE) start-socks5
	- $(MAKE) start-socks4
	- $(MAKE) start-https-proxy
	- $(MAKE) start-outline
	- $(MAKE) start-xray-vless-reality
	- $(MAKE) synapse-vacuum-clean
	- $(MAKE) synapse-backup-database
	- $(MAKE) synapse-backup-to-storage-vps
	- $(MAKE) start-coturn
	- $(MAKE) start-synapse
	- $(MAKE) start-demo
	- $(MAKE) start-nginx

start-socks4:
	- podman pull docker.io/dv0vd/socks4:1.1.3
	- podman run \
		-d \
		--name socks4 \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-p ${SOCKS4_PORT}:1080 \
		--restart unless-stopped \
		--memory=${SOCKS4_MEMORY} \
		--cpus=${SOCKS5_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/dv0vd/socks4

start-socks5:
	-@ rm ./deployment/data/socks5/logs/danted.log
	- touch ./deployment/data/socks5/logs/danted.log
	- podman pull docker.io/dv0vd/socks5:1.1.1
	- podman run \
		-d \
		--name socks5 \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-p ${SOCKS5_PORT}:1080 \
		-e SOCKS_USERNAME=${SOCKS5_USERNAME} \
		-e SOCKS_PASSWORD=${SOCKS5_PASSWORD} \
		-v ./deployment/data/socks5/logs/danted.log:/var/log/danted.log \
		--restart unless-stopped \
		--memory=${SOCKS5_MEMORY} \
		--cpus=${SOCKS5_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/dv0vd/socks5

start-https-proxy:
	- podman pull docker.io/dv0vd/https-proxy:1.2.0
	- podman run \
		-d \
		--name https-proxy \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-e DNS1=${DNS1} \
		-e DNS2=${DNS2} \
		-p ${HTTPS_PROXY_PORT}:3128 \
		--restart unless-stopped \
		--memory=${HTTPS_PROXY_MEMORY} \
		--cpus=${HTTPS_PROXY_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/dv0vd/https-proxy

start-outline:
	- mkdir ./deployment/data/outline/data/persisted-state
	- cp -f ./deployment/configs/outline/shadowbox_server_config.json ./deployment/data/outline/data/persisted-state/shadowbox_server_config.json
	- podman run \
		-d \
		--name outline \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/outline/data:/root/shadowbox \
		-v ./deployment/configs/outline:/app \
		-p 127.0.0.1:8081:8081 \
		-p ${OUTLINE_PORT}:28085 \
		-e SB_API_PREFIX=api \
		-e SB_API_PORT=8081 \
		-e SB_ENABLE_METRICS=false \
		-e SB_DEFAULT_SERVER_NAME=Dv0vD \
		-e SB_CERTIFICATE_FILE=/app/outline.crt \
		-e SB_PRIVATE_KEY_FILE=/app/outline.key \
		--restart unless-stopped \
		--memory=${OUTLINE_MEMORY} \
		--cpus=${OUTLINE_CPUS} \
		--cgroup-parent=/podman-group.slice \
		quay.io/outline/shadowbox:v1.12.3

start-xray-vless-reality:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/xray-vless-reality/xray_config_env.json > ./deployment/configs/xray-vless-reality/xray_config.json"
	- podman run \
		-d \
		--name xray-vless-reality \
		--network podman_network \
		-p ${XRAY_VLESS_REALITY_PORT}:443 \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/configs/xray-vless-reality/xray_config.json:/etc/xray/config.json:ro \
		--memory=${XRAY_VLESS_REALITY_MEMORY} \
		--cpus=${XRAY_VLESS_REALITY_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/teddysun/xray:25.10.15

start-nginx:
	- bash -c "set -a; . .env; set +a; envsubst '' < ./deployment/configs/nginx/nginx_main_env.conf > ./deployment/configs/nginx/nginx.conf"
	-@ rm ./deployment/data/nginx/logs/access.log
	-@ rm ./deployment/data/nginx/logs/error.log
	- podman run \
	-d \
	--name nginx \
	--network podman_network \
	-v ./deployment/configs/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
	-v ./deployment/configs/nginx:/deployment/nginx:ro \
	-v ./deployment/data/nginx/logs:/var/log/nginx \
	-v ./demo:/demo:ro \
	-v ./src:/app:ro \
	-v ./deployment/configs/pihole:/app/pihole:ro \
	-p 80:80 \
	-p 443:443 \
	-p 8448:8448 \
	--restart unless-stopped \
	--memory=${NGINX_MEMORY} \
	--cpus=${NGINX_CPUS} \
	--cgroup-parent=/podman-group.slice \
	docker.io/nginx:1.27.3

start-nginx-local:
	- bash -c "set -a; . .env; set +a; envsubst '' < ./deployment/configs/nginx/local_main_env.conf > ./deployment/configs/nginx/local.conf"
	-@ rm ./deployment/data/nginx/logs/access.log
	-@ rm ./deployment/data/nginx/logs/error.log
	- podman run \
	-d \
	--name nginx \
	--network podman_network \
	-v ./deployment/configs/nginx/local.conf:/etc/nginx/nginx.conf:ro \
	-v ./deployment/data/nginx/logs:/var/log/nginx \
	-v ./deployment/configs/nginx:/deployment/nginx:ro \
	-v ./deployment/configs/nginx/.htpasswd:/etc/nginx/.htpasswd:ro \
	-v ./demo:/demo:ro \
	-v ./src:/app:ro \
	-v ./deployment/configs/pihole:/app/pihole:ro \
	-p ${NGINX_LOCAL_PORT}:80 \
	--restart unless-stopped \
	--memory=${NGINX_MEMORY} \
	--cpus=${NGINX_CPUS} \
	docker.io/nginx:1.27.3

start-pihole:
	- podman run \
		-d \
		--name pihole \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-p 53:53/tcp \
		-p 53:53/udp \
		-p 127.0.0.1:80:80 \
		-e TZ=UTC \
		-e FTLCONF_webserver_api_password=${PIHOLE_ADMIN_PASSWORD} \
		-v ./deployment/data/pihole/data:/etc/pihole \
		--restart unless-stopped \
		--memory=${PIHOLE_MEMORY} \
		--cpus=${PIHOLE_CPUS} \
		--shm-size=${PIHOLE_SHM_SIZE} \
		--cgroup-parent=/podman-group.slice \
		docker.io/pihole/pihole:2025.08.0

start-mongo-demo:
	- podman run \
	-d \
	--name mongo-demo \
	--network podman_network \
	--restart unless-stopped \
	--memory=${MONGO_DEMO_MEMORY} \
	--cpus=${MONGO_DEMO_CPUS} \
	--cgroup-parent=/podman-group.slice \
	docker.io/mongo:7.0.16

start-postgres-demo:
	- podman run \
	-d \
	--name postgres-demo \
	-v ./deployment/configs/postgres/demo.sql:/docker-entrypoint-initdb.d/demo.sql \
	-e POSTGRES_PASSWORD=${POSTGRES_DEMO_PASSWORD} \
	--network podman_network \
	--restart unless-stopped \
	--memory=${POSTGRES_DEMO_MEMORY} \
	--cpus=${POSTGRES_DEMO_CPUS} \
	--cgroup-parent=/podman-group.slice \
	docker.io/postgres:15.14-alpine

start-postgres-synapse:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/postgres/synapse_env.sql > ./deployment/configs/postgres/synapse.sql"
	- mkdir ./deployment/data/postgres-synapse/data
	- podman run \
	-d \
	--name postgres-synapse \
	-v ./deployment/configs/postgres/synapse.sql:/docker-entrypoint-initdb.d/synapse.sql \
	-v ./deployment/data/postgres-synapse/data:/var/lib/postgresql/data \
	-v ./deployment/data/postgres-synapse/backups:/backups \
	-e POSTGRES_USER=${SYNAPSE_DB_USERNAME} \
	-e POSTGRES_PASSWORD=${SYNAPSE_DB_PASSWORD} \
	-p 127.0.0.1:${SYNAPSE_DB_HOST_PORT}:${SYNAPSE_DB_PORT} \
	--network podman_network \
	--restart unless-stopped \
	--memory=${SYNAPSE_DB_MEMORY} \
	--cpus=${SYNAPSE_DB_CPUS} \
	--cgroup-parent=/podman-group.slice \
	docker.io/postgres:15.14-alpine

start-db:
	- $(MAKE) start-mongo-demo
	- $(MAKE) start-postgres-demo
	- $(MAKE) start-postgres-synapse

start-demo:
	$(MAKE) start-timers
	$(MAKE) start-skillnotes
	$(MAKE) start-todo-manager

start-timers:
	- podman run \
		-d \
		-e DB_HOST=${TIMERS_DB_HOST} \
		-e DB_NAME=${TIMERS_DB_NAME} \
		-e BASE_PATH='/demo/timers/' \
		--name demo-timers \
		--network podman_network \
		--restart unless-stopped \
		--memory=${TIMERS_APP_MEMORY} \
		--cpus=${TIMERS_APP_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/dv0vd/demo-timers:1.0.5

start-skillnotes:
	- podman run \
		-d \
		-e DB_HOST=${SKILLNOTES_DB_HOST} \
		-e DB_PORT=${SKILLNOTES_DB_PORT} \
		-e DB_USER=${SKILLNOTES_DB_USER} \
		-e DB_PASSWORD=${SKILLNOTES_DB_PASSWORD} \
		-e DB_NAME=${SKILLNOTES_DB_NAME} \
		-e BASE_PATH='/demo/skillnotes/' \
		--name demo-skillnotes \
		--network podman_network \
		--restart unless-stopped \
		--memory=${SKILLNOTES_APP_MEMORY} \
		--cpus=${SKILLNOTES_APP_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/dv0vd/demo-skillnotes:1.0.10

start-todo-manager:
	- podman run \
		-d \
		-e DB_HOST=${TODO_MANAGER_DB_HOST} \
		-e DB_PORT=${TODO_MANAGER_DB_PORT} \
		-e DB_USER=${TODO_MANAGER_DB_USER} \
		-e DB_PASSWORD=${TODO_MANAGER_DB_PASSWORD} \
		-e DB_NAME=${TODO_MANAGER_DB_NAME} \
		-e HOST=${TODO_MANAGER_HOST} \
		--name demo-todo-manager \
		--network podman_network \
		--restart unless-stopped \
		--memory=${TODO_MANAGER_APP_MEMORY} \
		--cpus=${TODO_MANAGER_APP_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/dv0vd/demo-todo-manager:1.1.1

start-fail2ban:
	systemctl start fail2ban

start-synapse:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/synapse/homeserver_env.yaml > ./deployment/configs/synapse/homeserver.yaml"
	chmod 666 ./deployment/configs/synapse/homeserver.yaml
	chmod 777 ./deployment/data/synapse/logs
	- podman run \
	-d \
	--name synapse \
	-v ./deployment/data/synapse/logs:/var/log/synapse \
	-v ./deployment/data/synapse/data:/data \
	-v ./deployment/configs/synapse:/config \
	-e SYNAPSE_CONFIG_DIR=/config \
	--network podman_network \
	--memory=${SYNAPSE_APP_MEMORY} \
	--cpus=${SYNAPSE_APP_CPUS} \
	--cgroup-parent=/podman-group.slice \
	docker.io/matrixdotorg/synapse:v1.135.0

start-coturn:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/coturn/turnserver_env.conf > ./deployment/configs/coturn/turnserver.conf"
	- podman run \
	-d \
	--name coturn \
	-p ${COTURN_UDP_PORT}:3478 \
	-p ${COTURN_UDP_PORT}:3478/udp \
	-p ${COTURN_TCP_PORT}:5349 \
	-p ${COTURN_TCP_PORT}:5349/udp \
	-p ${COTURN_MIN_PORT}-${COTURN_MAX_PORT}:${COTURN_MIN_PORT}-${COTURN_MAX_PORT}/udp \
	-e DETECT_EXTERNAL_IP=yes \
	-e DETECT_RELAY_IP=yes \
	-v ./deployment/configs/coturn/turnserver.conf:/etc/coturn/turnserver.conf \
	--network podman_network \
	--memory=${COTURN_MEMORY} \
	--cpus=${COTURN_CPUS} \
	--cgroup-parent=/podman-group.slice \
	docker.io/coturn/coturn:4.7.0
