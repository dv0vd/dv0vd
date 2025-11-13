on-startup:
	- systemctl disable fail2ban
	- bash -c "set -a; . .env; set +a; envsubst < ./deployment/iptables/iptables_lite.sh > ./deployment/iptables/iptables.sh"
	- ./deployment/iptables/iptables.sh
	- shutdown -r 0:00
# - chmod +x ./deployment/configs/linux/iptables.sh && ./deployment/configs/linux/iptables.sh
	- $(MAKE) logs-clear
	- $(MAKE) restart-containers

