restart-containers:
	- $(MAKE) stop-containers
	- $(MAKE) podman-cleanup
# - $(MAKE) clean-containers
	- $(MAKE) podman-create-network
	- $(MAKE) start-containers

restart-socks4: stop-socks4 start-socks4

restart-socks5: stop-socks5 start-socks5

restart-https-proxy: stop-https-proxy start-https-proxy

restart-nginx: stop-nginx start-nginx

restart-db:
	- $(MAKE) stop-mongo
	- $(MAKE) stop-postgres
	- $(MAKE) start-mongo
	- $(MAKE) start-postgres

restart-mongo: stop-mongo start-mongo

restart-postgres: stop-postgres start-postgres

restart-demo: stop-demo start-demo restart-nginx

restart-timers: stop-timers start-timers restart-nginx

restart-skillnotes: stop-skillnotes start-skillnotes restart-nginx

restart-fail2ban: systemctl restart fail2ban