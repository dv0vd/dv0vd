restart-containers:
	- $(MAKE) stop-containers
	- $(MAKE) podman-cleanup
# - $(MAKE) clean-containers
	- $(MAKE) podman-create-network
	- $(MAKE) start-containers

restart-socks4: stop-socks4 start-socks4

restart-socks5: stop-socks5 start-socks5

restart-nginx: stop-nginx start-nginx

restart-demo: stop-demo start-demo restart-nginx

restart-timers: stop-timers start-timers restart-nginx
