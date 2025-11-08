on-startup:
	- shutdown -r 0:00
	- chmod +x ./deployment/configs/linux/iptables.sh && ./deployment/configs/linux/iptables.sh
	- $(MAKE) logs-clear
	- $(MAKE) podman-load-images
	- $(MAKE) restart-containers

