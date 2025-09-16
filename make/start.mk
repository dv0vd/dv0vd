start-containers:
	- $(MAKE) start-socks5
	- $(MAKE) start-socks4
	- $(MAKE) start-https-proxy
	- $(MAKE) start-pihole
	- $(MAKE) start-nginx

start-socks4:
	- podman pull docker.io/dv0vd/socks4:1.1.3
	- podman run \
		-d \
		--name socks4 \
		--network podman_network \
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
		-e DNS1=${DNS1} \
		-e DNS2=${DNS2} \
		-p ${HTTPS_PROXY_PORT}:3128 \
		--restart unless-stopped \
		--memory=${HTTPS_PROXY_MEMORY} \
		--cpus=${HTTPS_PROXY_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/dv0vd/https-proxy

start-nginx:
	-@ rm ./deployment/data/nginx/logs/access.log
	-@ rm ./deployment/data/nginx/logs/error.log
	- bash -c "set -a; . .env; set +a; envsubst '\$$ELEMENT_LOCATION_PREFIX' < ./deployment/configs/nginx/nginx_env.conf > ./deployment/configs/nginx/nginx.conf"
	- podman run \
	-d \
	--name nginx \
	--network host \
	-v ./deployment/configs/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
	-v ./deployment/configs/nginx:/deployment/nginx:ro \
	-v ./deployment/configs/nginx/.htpasswd:/etc/nginx/.htpasswd:ro \
	-v ./deployment/data/nginx/logs:/var/log/nginx \
	-v ./src:/app:ro \
	--restart unless-stopped \
	--memory=${NGINX_MEMORY} \
	--cpus=${NGINX_CPUS} \
	--cgroup-parent=/podman-group.slice \
	docker.io/nginx:1.27.3

start-nginx-local:
	-@ rm ./deployment/data/nginx/logs/access.log
	-@ rm ./deployment/data/nginx/logs/error.log
	- bash -c "set -a; . .env; set +a; envsubst '\$$ELEMENT_LOCATION_PREFIX' < ./deployment/configs/nginx/local_env.conf > ./deployment/configs/nginx/local.conf"
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
	-p ${NGINX_LOCAL_PORT:-8080}:80 \
	--restart unless-stopped \
	--memory=${NGINX_MEMORY} \
	--cpus=${NGINX_CPUS} \
	docker.io/nginx:1.27.3

start-pihole:
	- podman run \
		-d \
		--name pihole \
		--network podman_network \
		-p 53:53/tcp \
		-p 53:53/udp \
		-p 127.0.0.1:80:80 \
		-e TZ=UTC \
		-e FTLCONF_webserver_api_password=${PIHOLE_ADMIN_PASSWORD} \
		-v ./deployment/data/pihole/data:/etc/pihole \
		--restart unless-stopped \
		--memory=${PIHOLE_MEMORY} \
		--cpus=${PIHOLE_CPUS} \
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

start-timers:
	cp ./.env ./demo/demo-timers/.env
	cd ./demo/demo-timers
	- make start-app

start-skillnotes:
	cp ./.env ./demo/demo-skillnotes/.env
	cd ./demo/demo-skillnotes
	- make build
	- make start-app

start-fail2ban:
	systemctl enable fail2ban
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
