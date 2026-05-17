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
	touch /root/.config/rclone/rclone.conf
	bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/rclone/rclone_env.conf > /root/.config/rclone/rclone.conf"
	ssh-keygen -R ${RCLONE_HOST} || true
	ssh-keyscan -p ${RCLONE_PORT} ${RCLONE_HOST} >> /root/.ssh/known_hosts