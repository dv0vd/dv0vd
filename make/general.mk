status-containers:
	podman stats

# clean-containers:
# 	podman rm -af

podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 podman_network

podman-load-images:
	podman load < ./deployment/images/dv0vd-socks4_1.0.4.tar
	podman load < ./deployment/images/dv0vd-socks5_1.0.10.tar
	podman load < ./deployment/images/mongo_7.0.16.tar
	podman load < ./deployment/images/nginx_1.27.3.tar
	podman load < ./deployment/images/node_20.18.1-bookworm.tar
	podman load < ./deployment/images/postgres_15.10-bookworm.tar

schedule-midnight-reboot:
	shutdown -r 0:00

init-demo:
	$(MAKE) init-timers

refresh-demo:
	rm ./demo -rf
	$(MAKE) init-demo

init-timers:
	mkdir ./demo
	cd ./demo
	git clone git@github.com:dv0vd/demo-timers.git
	cp ../.env ./demo-timers/.env
	cd ./demo-timers
	make init

init-skillnotes:
	mkdir ./demo
	cd ./demo
	git clone git@github.com:dv0vd/demo-skillnotes.git
	cp ../.env ./demo-skillnotes/.env
	cd ./demo-skillnotes
	make init