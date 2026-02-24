on-startup:
	- systemctl disable fail2ban
	- $(MAKE) stop-fail2ban
	- $(MAKE) iptables-apply-rules
	- shutdown -r 0:00
	- $(MAKE) start-fail2ban
	- $(MAKE) certbot-renew
	- $(MAKE) logs-clear
	- rm -rf /var/tmp/*
	- $(MAKE) restart-containers
