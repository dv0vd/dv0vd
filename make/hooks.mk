on-startup:
	- systemctl disable fail2ban
	- $(MAKE) stop-fail2ban
	- ip addr add 9.9.9.9/32 dev lo || true
	- $(MAKE) iptables-apply-rules
	- shutdown -r 0:00
	- $(MAKE) start-fail2ban
	- $(MAKE) logs-clear
	- $(MAKE) restart-containers
