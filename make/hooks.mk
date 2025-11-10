on-startup:
	- shutdown -r 0:00
# - chmod +x ./deployment/configs/linux/iptables.sh && ./deployment/configs/linux/iptables.sh
	- echo "nameserver ${DNS1}" > /etc/resolv.conf
	- echo "nameserver ${DNS2}" >> /etc/resolv.conf
	- $(MAKE) logs-clear
	- $(MAKE) podman-load-images
	- $(MAKE) restart-containers

