start-containers:
	- $(MAKE) podman-load-images
	- $(MAKE) start-nginx
	- $(MAKE) start-socks5
	- $(MAKE) start-socks4
	- $(MAKE) start-db
	- $(MAKE) start-demo

start-socks4:
	- podman pull docker.io/dv0vd/socks4
	- podman run \
		-d \
		--name socks4 \
		--network podman_network \
		-p ${SOCKS4_PORT}:1080 \
		--restart unless-stopped \
		--memory=${SOCKS4_MEMORY} \
		--cpus=${SOCKS5_CPUS} \
		docker.io/dv0vd/socks4

start-socks5:
	- podman pull docker.io/dv0vd/socks5
	- podman run \
		-d \
		--name socks5 \
		--network podman_network \
		-p ${SOCKS5_PORT}:1080 \
		-e SOCKS_USERNAME=${SOCKS5_USERNAME} \
		-e SOCKS_PASSWORD=${SOCKS5_PASSWORD} \
		--restart unless-stopped \
		--memory=${SOCKS5_MEMORY} \
		--cpus=${SOCKS5_CPUS} \
		docker.io/dv0vd/socks5

start-nginx:
	- podman run \
	-d \
	--name nginx \
	--network podman_network \
	-v ./deployment/configs/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
	-v ./deployment/configs/nginx:/deployment/nginx:ro \
	-v ./demo:/demo:ro \
	-v ./src:/app:ro \
	-p 80:80 \
	-p 443:443 \
	--restart unless-stopped \
	--memory=${NGINX_MEMORY} \
	--cpus=${NGINX_CPUS} \
	docker.io/nginx:1.27.3

start-mongo:
	- podman run \
	-d \
	--name mongo \
	--network podman_network \
	--restart unless-stopped \
	--memory=${MONGO_MEMORY} \
	--cpus=${MONGO_CPUS} \
	docker.io/mongo:7.0.16

start-db:
	- $(MAKE) start-mongo

start-demo:
	$(MAKE) start-timers

start-timers:
	cp ./.env ./demo/demo-timers/.env
	cd ./demo/demo-timers
	- make start-app