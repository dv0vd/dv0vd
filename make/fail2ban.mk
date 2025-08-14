fail2ban-status:
	fail2ban-client status
	fail2ban-client status sshd
	fail2ban-client status nginx-http-auth
	fail2ban-client status nginx-limit-req
	fail2ban-client status nginx-botsearch
	fail2ban-client status nginx-bad-request
	fail2ban-client status nginx-not-found
	fail2ban-client status nginx-redirected
	fail2ban-client status danted

fail2ban-unban-all:
	fail2ban-client unban --all