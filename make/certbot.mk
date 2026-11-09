certbot-issue-proxies:
	- set -a; . ./.env; set +a
	PROXY_NAME=
	for entry in $$PROXIES; do
		p=$${entry%%=*}; ip=$${entry#*=}
		if [ "$$ip" = "$$PUBLIC_IP" ]; then PROXY_NAME=$$p; break; fi
	done
	- $(MAKE) start-nginx-certbot
	- $(MAKE) certbot-issue-proxy PROXY_NAME=$$PROXY_NAME
	- $(MAKE) stop-nginx-certbot

certbot-issue-website:
	- podman rm certbot
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		-v ./deployment/data/letsencrypt/acme:/app/acme \
		docker.io/certbot/certbot:v5.3.1 certonly \
 		--webroot \
		--webroot-path=/app/acme \
		-d ${BASE_URL} \
		-d www.${BASE_URL} \
		--email postmaster@${BASE_URL} \
		--agree-tos \
		--no-eff-email

certbot-issue-email:
	- podman rm certbot
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		-v ./deployment/data/letsencrypt/acme:/app/acme \
		docker.io/certbot/certbot:v5.3.1 certonly \
 		--webroot \
		--webroot-path=/app/acme \
		-d mail.${BASE_URL} \
		-d www.mail.${BASE_URL} \
		--email postmaster@${BASE_URL} \
		--agree-tos \
		--no-eff-email

certbot-issue-ntfy:
	- podman rm certbot
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		-v ./deployment/data/letsencrypt/acme:/app/acme \
		docker.io/certbot/certbot:v5.3.1 certonly \
 		--webroot \
		--webroot-path=/app/acme \
		-d ${NTFY_URL}.${BASE_URL} \
		-d www.${NTFY_URL}.${BASE_URL} \
		--email postmaster@${BASE_URL} \
		--agree-tos \
		--no-eff-email

certbot-issue-livekit:
	- podman rm certbot
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		-v ./deployment/data/letsencrypt/acme:/app/acme \
		docker.io/certbot/certbot:v5.3.1 certonly \
 		--webroot \
		--webroot-path=/app/acme \
		-d ${LIVEKIT_URL}.${BASE_URL} \
		-d www.${LIVEKIT_URL}.${BASE_URL} \
		--email postmaster@${BASE_URL} \
		--agree-tos \
		--no-eff-email

certbot-issue-proxy:
	- podman rm certbot
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		-v ./deployment/data/letsencrypt/acme:/app/acme \
		docker.io/certbot/certbot:v5.3.1 certonly \
 		--webroot \
		--webroot-path=/app/acme \
		-d ${PROXY_NAME}.${BASE_URL} \
		-d www.${PROXY_NAME}.${BASE_URL} \
		--email postmaster@${BASE_URL} \
		--agree-tos \
		--no-eff-email

certbot-issue-open-webui:
	- podman rm certbot
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		-v ./deployment/data/letsencrypt/acme:/app/acme \
		docker.io/certbot/certbot:v5.3.1 certonly \
 		--webroot \
		--webroot-path=/app/acme \
		-d ${OPEN_WEBUI_URL}.${BASE_URL} \
		-d www.${OPEN_WEBUI_URL}.${BASE_URL} \
		--email postmaster@${BASE_URL} \
		--agree-tos \
		--no-eff-email

certbot-renew:
	- $(MAKE) start-nginx-certbot
	- podman rm certbot
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		-v ./deployment/data/letsencrypt/acme:/app/acme \
		docker.io/certbot/certbot:v5.3.1 renew
	- $(MAKE) stop-nginx-certbot
