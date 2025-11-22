iptables-rules-filter:
	iptables -vnL

iptables-apply-rules:
	bash -c 'set -a; . .env; set +a; envsubst "\$$SSH_PORT" < ./deployment/configs/iptables/iptables_lite.sh > ./deployment/configs/iptables/iptables.sh'
	chmod +x ./deployment/configs/iptables/iptables.sh && ./deployment/configs/iptables/iptables.sh