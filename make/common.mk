disable-ipv6:
	sysctl -w net.ipv6.conf.all.disable_ipv6=1
	sysctl -w net.ipv6.conf.default.disable_ipv6=1
	sysctl -w net.ipv6.conf.lo.disable_ipv6=1

generate-xray-private-key:
	podman run docker.io/teddysun/xray:26.6.27 xray x25519

generate-xray-short-id:
	openssl rand -hex 8

disk-usage:
	du -h ${path} | sort -hr

rclone-configure:
	mkdir -p /root/.config/rclone
	bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/rclone/rclone_env.conf > /root/.config/rclone/rclone.conf"

ssh-generate-config:
	echo 'PasswordAuthentication no' > /etc/ssh/sshd_config.d/00-dv0vd.conf
	echo "Port ${SSH_PORT}" >> /etc/ssh/sshd_config.d/00-dv0vd.conf

sip-debug:
	podman exec -it sip asterisk -rx "pjsip set logger on"

reserve-ports:
	- bash -c "set -a; . .env; set +a; envsubst '\$$LIVEKIT_TURN_UDP_PORT \$$LIVEKIT_TURN_TCP_PORT \$$LIVEKIT_FALLBACK_PORT \$$LIVEKIT_MIN_PORT \$$LIVEKIT_MAX_PORT \$$LIVEKIT_TURN_MIN_PORT \$$LIVEKIT_TURN_MAX_PORT \$$COTURN_PORT \$$COTURN_TLS_PORT \$$COTURN_MIN_PORT \$$COTURN_MAX_PORT \$$SIP_PORT \$$SIP_RTP_MIN_PORT \$$SIP_RTP_MAX_PORT' < ./deployment/configs/linux/sysctl_env.conf > /etc/sysctl.d/99-dv0vd.conf"
	- sysctl -p /etc/sysctl.d/99-dv0vd.conf
