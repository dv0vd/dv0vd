status-containers:
	podman stats

clean-containers:
	podman rm -a

podman-cleanup:
	podman system reset

podman-create-network:
	podman network create --ipv6 podman_network

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