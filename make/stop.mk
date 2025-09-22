stop-containers:
	- $(MAKE) stop-nginx
	- $(MAKE) stop-demo
	- $(MAKE) stop-socks4
	- $(MAKE) stop-socks5
	- $(MAKE) stop-https-proxy
	- $(MAKE) stop-coturn
	- $(MAKE) stop-synapse
	- $(MAKE) stop-db

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
	- $(MAKE) stop-postgres-synapse

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
	- podman stop demo-timers
	- podman rm demo-timers

stop-skillnotes:
	- podman stop demo-skillnotes
	- podman rm demo-skillnotes

stop-fail2ban:
	systemctl disable fail2ban
	systemctl stop fail2ban

stop-synapse:
	- podman stop synapse
	- podman rm synapse

stop-coturn:
	- podman stop coturn
	- podman rm coturn

stop-pihole:
	- podman stop pihole
	- podman rm pihole
