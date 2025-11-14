on-startup:
	- systemctl disable fail2ban
	- bash -c "set -a; . .env; set +a; envsubst '$$SSH_PORT $$SOCKS4_PORT $$SOCKS5_PORT $$OUTLINE_PORT' < ./deployment/configs/iptables/iptables_lite.sh > ./deployment/configs/iptables/iptables.sh"
# - chmod +x ./deployment/configs/iptables/iptables.sh && ./deployment/configs/iptables/iptables.sh
	- shutdown -r 0:00
	- $(MAKE) logs-clear
	- $(MAKE) restart-containers

