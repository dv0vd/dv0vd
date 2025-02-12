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

stop-db:
	- $(MAKE) stop-mongo

stop-mongo:
	- podman stop mongo
	- podman rm mongo

stop-demo:
	$(MAKE) stop-timers

stop-timers:
	cd ./demo/demo-timers
	- podman stop timers_app
	- podman rm timers_app