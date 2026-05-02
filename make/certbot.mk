certbot-issue:
	- $(MAKE) certbot-issue-website
	- $(MAKE) certbot-issue-ntfy
	- $(MAKE) certbot-issue-livekit
	- $(MAKE) certbot-issue-email

certbot-issue-website:
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

certbot-renew:
	podman run \
		--rm \
		--name certbot \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt \
		docker.io/certbot/certbot:v5.3.1 renew
