disable-ipv6:
	sysctl -w net.ipv6.conf.all.disable_ipv6=1
	sysctl -w net.ipv6.conf.default.disable_ipv6=1
	sysctl -w net.ipv6.conf.lo.disable_ipv6=1

generate-xray-private-key:
	podman run docker.io/teddysun/xray:25.10.15 xray x25519

generate-xray-short-id:
	openssl rand -hex 8
