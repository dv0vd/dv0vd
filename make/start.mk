start-containers:
	- echo "nameserver ${DNS1}" > /etc/resolv.conf
	- echo "nameserver ${DNS2}" >> /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- $(MAKE) email-backup-to-storage-vps
	- $(MAKE) start-email
	- $(MAKE) start-db
	- $(MAKE) start-livekit-redis
	- $(MAKE) start-mtproto
	- $(MAKE) start-whitelist-bypass
	- $(MAKE) start-socks5
	- $(MAKE) start-socks4
	- $(MAKE) start-https-proxy
	- $(MAKE) start-outline
	- $(MAKE) start-xray-vless-reality
	- $(MAKE) start-doh-server
	- $(MAKE) start-ntfy
	- $(MAKE) start-sip
	- $(MAKE) rustdesk-backup-to-storage-vps
	- $(MAKE) start-rustdesk
	- $(MAKE) synapse-vacuum-clean
	- $(MAKE) synapse-backup-database
	- $(MAKE) synapse-backup-to-storage-vps
	- $(MAKE) start-coturn
	- $(MAKE) start-livekit
	- $(MAKE) start-matrix-rtc
	- $(MAKE) start-synapse
	- $(MAKE) start-demo
	- $(MAKE) start-nginx

start-socks4:
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
	- bash -c "set -a; . .env; set +a; envsubst '\$$BASE_URL \$$NTFY_URL \$$LIVEKIT_URL \$$MTPROTO_URL' < ./deployment/configs/nginx/nginx_main_env.conf > ./deployment/configs/nginx/nginx.conf"
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
	-v ./deployment/data/letsencrypt/acme:/app/letsencrypt/acme:ro \
	-v ./deployment/data/letsencrypt/data:/app/letsencrypt/certificates:ro \
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
	- rm deployment/data/pihole/data/pihole-FTL.db*
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

start-doh-server:
	- podman run \
		-d \
		--name doh-server \
		--network podman_network \
		-e UPSTREAM_DNS_SERVER="udp:${DNS1}:53,udp:${DNS2}:53" \
		-e DOH_HTTP_PREFIX="/dns-query" \
		--restart unless-stopped \
		--memory=${DOH_SERVER_MEMORY} \
		--cpus=${DOH_SERVER_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/satishweb/doh-server:v2.3.10-alpine

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
		docker.io/dv0vd/demo-skillnotes:1.0.11

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
		--user 0 \
		-v ./deployment/configs/coturn/turnserver.conf:/etc/coturn/turnserver.conf \
		-v ./deployment/data/letsencrypt/data:/app/letsencrypt:ro \
		--network host \
		--memory=${COTURN_MEMORY} \
		--cpus=${COTURN_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/coturn/coturn:4.7.0

start-ntfy:
	- podman run \
		-d \
		--name ntfy \
		--network podman_network \
		-v ./deployment/data/ntfy:/var/lib/ntfy \
		-e NTFY_BASE_URL=https://${NTFY_URL}.${BASE_URL} \
		-e NTFY_CACHE_FILE=/var/lib/ntfy/cache.db \
		-e NTFY_CACHE_DURATION=720h \
		-e NTFY_AUTH_FILE=/var/lib/ntfy/auth.db \
		-e NTFY_AUTH_DEFAULT_ACCESS=read-write \
		-e NTFY_BEHIND_PROXY=true \
		-e NTFY_ATTACHMENT_CACHE_DIR=/var/lib/ntfy/attachments \
		-e NTFY_ENABLE_LOGIN=false \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		--restart unless-stopped \
		--memory=${NTFY_MEMORY} \
		--cpus=${NTFY_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/binwiederhier/ntfy:v2.17 serve

start-livekit-redis:
	- podman run \
		-d \
		--name livekit-redis \
		--network podman_network \
		--restart unless-stopped \
		--memory=${LIVEKIT_REDIS_MEMORY} \
		--cpus=${LIVEKIT_REDIS_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/redis:8.4.0-alpine

start-livekit:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/livekit/livekit_env.yaml > ./deployment/configs/livekit/livekit.yaml"
	- podman run \
		-d \
		--name livekit \
		--network podman_network \
		-v ./deployment/configs/livekit/livekit.yaml:/app/livekit.yaml:ro \
		-v ./deployment/data/letsencrypt/data:/app/letsencrypt:ro \
		-p ${LIVEKIT_TURN_UDP_PORT}:${LIVEKIT_TURN_UDP_PORT}/udp \
		-p ${LIVEKIT_TURN_TCP_PORT}:${LIVEKIT_TURN_TCP_PORT} \
		-p ${LIVEKIT_FALLBACK_PORT}:${LIVEKIT_FALLBACK_PORT} \
		-p ${LIVEKIT_MIN_PORT}-${LIVEKIT_MAX_PORT}:${LIVEKIT_MIN_PORT}-${LIVEKIT_MAX_PORT}/udp \
		-p ${LIVEKIT_TURN_MIN_PORT}-${LIVEKIT_TURN_MAX_PORT}:${LIVEKIT_TURN_MIN_PORT}-${LIVEKIT_TURN_MAX_PORT}/udp \
		--restart unless-stopped \
		--memory=${LIVEKIT_MEMORY} \
		--cpus=${LIVEKIT_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/livekit/livekit-server:v1.9.11 --config /app/livekit.yaml

start-matrix-rtc:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/livekit/livekit_env.yaml > ./deployment/configs/livekit/livekit.yaml"
	- podman run \
		-d \
		--name matrix-rtc \
		-e LIVEKIT_URL=wss://${LIVEKIT_URL}.${BASE_URL} \
		-e LIVEKIT_KEY=${LIVEKIT_API_KEY} \
		-e LIVEKIT_SECRET=${LIVEKIT_API_SECRET} \
		-e LIVEKIT_FULL_ACCESS_HOMESERVERS=${BASE_URL} \
		--network podman_network \
		--restart unless-stopped \
		--memory=${MATRIX_RTC_MEMORY} \
		--cpus=${MATRIX_RTC_CPUS} \
		--cgroup-parent=/podman-group.slice \
		ghcr.io/element-hq/lk-jwt-service:0.4.1

start-email:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/email/dovecot_env.cf > ./deployment/data/email/configs/dovecot.cf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/email/postfix-virtual_env.cf > ./deployment/data/email/configs/postfix-virtual.cf"
	- podman run \
		-d \
		--name email \
		--network podman_network \
		-e OVERRIDE_HOSTNAME=mail.${BASE_URL} \
		-e TZ=UTC \
		-e ENABLE_AMAVIS=0 \
		-e ENABLE_POP3=1 \
		-e ENABLE_IMAP=1 \
		-e ENABLE_CLAMAV=0 \
		-e ENABLE_FAIL2BAN=0 \
		-e SSL_TYPE=letsencrypt \
		-e SPOOF_PROTECTION=1 \
		-e POSTMASTER_ADDRESS=postmaster@${BASE_URL} \
		-e ENABLE_UPDATE_CHECK=0 \
		-e ENABLE_RSPAMD=0 \
		-e ENABLE_SPAMASSASSIN=0 \
		-e ENABLE_DNSBL=0 \
		-e ENABLE_MTA_STS=1 \
		-e ENABLE_OPENDKIM=1 \
		-e ENABLE_OPENDMARC=1 \
		-e ENABLE_POLICYD_SPF=1 \
		-e ENABLE_SRS=0 \
		-e POSTFIX_REJECT_UNKNOWN_CLIENT_HOSTNAME=1 \
		-e ENABLE_QUOTAS=1 \
		-e POSTFIX_MESSAGE_SIZE_LIMIT=52428800 \
		-v ./deployment/data/email/data:/var/mail \
		-v ./deployment/data/email/state:/var/mail-state \
		-v ./deployment/data/email/logs:/var/log/mail \
		-v ./deployment/data/email/configs:/tmp/docker-mailserver \
		-v ./deployment/data/letsencrypt/data:/etc/letsencrypt:ro \
		-p 25:25 \
		-p 465:465 \
		-p 993:993 \
		--restart unless-stopped \
		--memory=${EMAIL_MEMORY} \
		--cpus=${EMAIL_CPUS} \
		--cgroup-parent=/podman-group.slice \
		ghcr.io/docker-mailserver/docker-mailserver:15.1.0

start-rustdesk:
	- podman run \
		-d \
		--name rustdesk-id \
		--network podman_network \
		-v ./deployment/data/rustdesk:/root \
		-p 21115:21115 \
		-p ${RUSTDESK_ID_PORT}:21116 \
		-p ${RUSTDESK_ID_PORT}:21116/udp \
		--restart unless-stopped \
		--memory=${RUSTDESK_ID_MEMORY} \
		--cpus=${RUSTDESK_ID_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/rustdesk/rustdesk-server:1.1.15 hbbs
	- podman run \
		-d \
		--name rustdesk-relay \
		-p ${RUSTDESK_RELAY_PORT}:21117 \
		--network podman_network \
		-v ./deployment/data/rustdesk:/root \
		--restart unless-stopped \
		--memory=${RUSTDESK_RELAY_MEMORY} \
		--cpus=${RUSTDESK_RELAY_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/rustdesk/rustdesk-server:1.1.15 hbbr

start-mtproto:
	- podman run \
		-d \
		--name mtproto \
		-v ./deployment/configs/mtproto/mtg.toml:/config.toml \
		-p ${MTPROTO_PORT}:3128 \
		--network podman_network \
		--dns ${DNS1} \
		--dns ${DNS2} \
		--dns 1.1.1.1 \
		--dns 8.8.8.8 \
		--restart unless-stopped \
		--memory=${MTPROTO_MEMORY} \
		--cpus=${MTPROTO_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/nineseconds/mtg:2.2.8 run /config.toml

start-whitelist-bypass:
	- podman run \
		-d \
		--name whitelist-bypass \
		-e VK_TOKEN=${WHITELIST_BYPASS_VK_TOKEN} \
		-e VK_GROUP_ID=${WHITELIST_BYPASS_VK_GROUP_ID} \
		-e TM_COOKIES=/app/cookies-telemost.json \
		-e WB_COOKIES=/app/cookies-wbstream.json \
		-e VK_COOKIES=/app/cookies-vk.json \
		-v ./deployment/configs/whitelist-bypass:/app \
		--network podman_network \
		--restart unless-stopped \
		--memory=${WHITELIST_BYPASS_MEMORY} \
		--cpus=${WHITELIST_BYPASS_CPUS} \
		--cgroup-parent=/podman-group.slice \
		ghcr.io/kulikov0/whitelist-bypass-bot:v0.3.7

start-sip:
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/transport_env.conf > ./deployment/configs/sip/pjsip.d/transport.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/rtp_env.conf > ./deployment/configs/sip/rtp.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/000_templates_env.conf > ./deployment/configs/sip/pjsip.d/000_templates.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/100_env.conf > ./deployment/configs/sip/pjsip.d/100.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/101_env.conf > ./deployment/configs/sip/pjsip.d/101.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/102_env.conf > ./deployment/configs/sip/pjsip.d/102.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/103_env.conf > ./deployment/configs/sip/pjsip.d/103.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/104_env.conf > ./deployment/configs/sip/pjsip.d/104.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/105_env.conf > ./deployment/configs/sip/pjsip.d/105.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/106_env.conf > ./deployment/configs/sip/pjsip.d/106.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/107_env.conf > ./deployment/configs/sip/pjsip.d/107.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/108_env.conf > ./deployment/configs/sip/pjsip.d/108.conf"
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/sip/pjsip.d/109_env.conf > ./deployment/configs/sip/pjsip.d/109.conf"
	- mkdir -p ./deployment/data/sip/certs
	-@ rm ./deployment/data/sip/logs/*
	- touch ./deployment/data/sip/logs/messages
	- cp -Lf ./deployment/data/letsencrypt/data/live/${BASE_URL}/fullchain.pem ./deployment/data/sip/certs/fullchain.pem
	- cp -Lf ./deployment/data/letsencrypt/data/live/${BASE_URL}/privkey.pem ./deployment/data/sip/certs/privkey.pem
	- cp -Lf ./deployment/data/letsencrypt/data/live/${BASE_URL}/chain.pem ./deployment/data/sip/certs/chain.pem
	- chmod 644 ./deployment/data/sip/certs/fullchain.pem ./deployment/data/sip/certs/privkey.pem ./deployment/data/sip/certs/chain.pem
	- podman run \
		-d \
		--name sip \
		-v ./deployment/configs/sip:/etc/asterisk \
		-v ./deployment/data/sip/logs:/var/log/asterisk \
		-v ./deployment/data/sip/certs:/app/certs:ro \
		-p ${SIP_PORT}:5061/tcp \
		-p ${SIP_RTP_MIN_PORT}-${SIP_RTP_MAX_PORT}:${SIP_RTP_MIN_PORT}-${SIP_RTP_MAX_PORT}/udp \
		--network podman_network \
		--restart unless-stopped \
		--memory=${SIP_MEMORY} \
		--cpus=${SIP_CPUS} \
		--cgroup-parent=/podman-group.slice \
		docker.io/andrius/asterisk:22.8-cert3_debian-trixie asterisk -f -vvvvv
