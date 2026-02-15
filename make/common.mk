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
		-v ./deployment/data/letsencrypt:/etc/letsencrypt \
		docker.io/certbot/certbot:v5.3.1 certonly \
 		--webroot \
		--webroot-path=/app/letsencrypt \
		-d dv0vd.dev \
		-d www.dv0vd.dev \
		--email postmaster@dv0vd.dev \
		--agree-tos \
		--no-eff-email

