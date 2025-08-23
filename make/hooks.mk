on-startup:
	- shutdown -r 0:00
	- $(MAKE) logs-clear
	- $(MAKE) podman-load-images
	- $(MAKE) restart-containers

