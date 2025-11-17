on-startup:
	- systemctl disable fail2ban
	- $(MAKE) stop-fail2ban
	- ip addr add 9.9.9.9/32 dev lo || true
	- bash -c 'set -a; . .env; set +a; envsubst "\$$SSH_PORT" < ./deployment/configs/iptables/iptables_main.sh > ./deployment/configs/iptables/iptables.sh'
	- chmod +x ./deployment/configs/iptables/iptables.sh && ./deployment/configs/iptables/iptables.sh
	- shutdown -r 0:00
	- $(MAKE) start-fail2ban
	- $(MAKE) logs-clear
	- $(MAKE) restart-containers
