on-startup:
	- shutdown -r 0:00
	- $(MAKE) restart-containers

