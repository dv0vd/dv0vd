podman-cleanup:
	podman system reset -f

podman-create-network:
	podman network create --ipv6 --disable-dns --interface-name podman-main podman_network

podman-create-whitelist-bypass-network:
	podman network create --subnet 10.89.10.0/24 --disable-dns --interface-name podman-wlb whitelist_bypass_network

podman-info:
	podman ps -w 1

podman-stats:
	podman stats -i 1

podman-resources:
	systemctl status podman-group.slice