on-startup:
	- systemctl disable fail2ban
	- $(MAKE) stop-fail2ban
	- $(MAKE) iptables-apply-rules
	- $(MAKE) rclone-configure
	- shutdown -r 0:00
	- $(MAKE) fail2ban-configure
	- $(MAKE) start-fail2ban
	- $(MAKE) logs-clear
	- $(MAKE) restart-containers
