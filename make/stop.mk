stop-containers:
	podman stop -a

stop-socks4:
	- podman stop socks4
	- podman rm socks4

stop-socks5:
	- podman stop socks5
	- podman rm socks5

stop-https-proxy:
	- podman stop https-proxy
	- podman rm https-proxy

stop-nginx:
	- podman stop nginx
	- podman rm nginx

stop-db:
	- $(MAKE) stop-mongo-demo
	- $(MAKE) stop-postgres-demo

stop-mongo-demo:
	- podman stop mongo-demo
	- podman rm mongo-demo

stop-postgres-demo:
	- podman stop postgres-demo
	- podman rm postgres-demo

stop-postgres-synapse:
	- podman stop postgres-synapse
	- podman rm postgres-synapse

stop-demo:
	$(MAKE) stop-timers
	$(MAKE) stop-skillnotes

stop-timers:
	cd ./demo/demo-timers
	- make stop

stop-skillnotes:
	cd ./demo/demo-skillnotes
	- make stop

stop-fail2ban:
	systemctl disable fail2ban
	systemctl stop fail2ban

stop-synapse:
	- podman stop synapse
	- podman rm synapse

# stop-synapse-admin:
# 	- podman stop synapse-admin
# 	- podman rm synapse-admin

stop-element:
	- podman stop element
	- podman rm element