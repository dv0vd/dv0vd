disable-ipv6:
	sysctl -w net.ipv6.conf.all.disable_ipv6=1
	sysctl -w net.ipv6.conf.default.disable_ipv6=1
	sysctl -w net.ipv6.conf.lo.disable_ipv6=1

generate-xray-private-key:
	podman run docker.io/teddysun/xray:25.10.15 xray x25519

generate-xray-short-id:
	openssl rand -hex 8

email-init:
	podman run --rm -it \
		-v ./deployment/configs/email:/tmp/docker-mailserver \
		ghcr.io/docker-mailserver/docker-mailserver:15.1.0 \
		setup config dkim domain ${BASE_URL}
