stop-containers:
	podman stop -a

stop-socks4:
	- podman stop socks4
	- podman rm socks4

stop-socks5:
	- podman stop socks5
	- podman rm socks5

stop-nginx:
	- podman stop nginx
	- podman rm nginx

stop-demo:
	$(MAKE) stop-timers

stop-timers:
	cd ./demo/demo-timers
	make stop