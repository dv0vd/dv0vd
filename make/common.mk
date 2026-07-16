disable-ipv6:
	sysctl -w net.ipv6.conf.all.disable_ipv6=1
	sysctl -w net.ipv6.conf.default.disable_ipv6=1
	sysctl -w net.ipv6.conf.lo.disable_ipv6=1

generate-xray-private-key:
	podman run docker.io/teddysun/xray:25.10.15 xray x25519

generate-xray-short-id:
	openssl rand -hex 8

disk-usage:
	du -h ${path} | sort -hr

rclone-configure:
	mkdir -p /root/.config/rclone
	bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/rclone/rclone_env.conf > /root/.config/rclone/rclone.conf"

sip-debug:
	podman exec -it sip asterisk -rx pjsip set logger on
