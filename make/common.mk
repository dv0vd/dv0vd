disable-ipv6:
	sysctl -w net.ipv6.conf.all.disable_ipv6=1
	sysctl -w net.ipv6.conf.default.disable_ipv6=1
	sysctl -w net.ipv6.conf.lo.disable_ipv6=1

generate-xray-private-key:
	podman run docker.io/teddysun/xray:25.10.15 xray x25519

generate-xray-short-id:
	openssl rand -hex 8

issue-letsencrypt-certificate:
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
		-d dv0vd.dev \
		-d www.dv0vd.dev \
		--email postmaster@dv0vd.dev \
		--agree-tos \
		--no-eff-email



# 	- podman run \
# 		-d \
# 		--rm \
# 		--name certbot \
# 		--network podman_network \
# 		-v ./deployment/data/ntfy:/var/lib/ntfy \
# 		-e NTFY_BASE_URL=https://ntfy.dv0vd.dev \
# 		-e NTFY_CACHE_FILE=/var/lib/ntfy/cache.db \
# 		-e NTFY_AUTH_FILE=/var/lib/ntfy/auth.db \
# 		-e NTFY_AUTH_DEFAULT_ACCESS=read-write \
# 		-e NTFY_BEHIND_PROXY=yes \
# 		-e NTFY_ATTACHMENT_CACHE_DIR=/var/lib/ntfy/attachments \
# 		-e NTFY_ENABLE_LOGIN=false \
# 		--dns ${DNS1} \
# 		--dns ${DNS2} \
# 		--dns 1.1.1.1 \
# 		--dns 8.8.8.8 \
# 		--restart unless-stopped \
# 		--memory=${NTFY_MEMORY} \
# 		--cpus=${NTFY_CPUS} \
# 		--cgroup-parent=/podman-group.slice \
# 		docker.io/binwiederhier/ntfy:v2.17