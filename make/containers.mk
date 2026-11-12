start-containers:
	- echo "nameserver ${DNS_1}" > /etc/resolv.conf
	- echo "nameserver ${DNS_2}" >> /etc/resolv.conf
	- echo "nameserver ${DNS_3}" >> /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	- echo "options timeout:1 attempts:1" >> /etc/resolv.conf
	- $(MAKE) email-backup-to-storage-vps
	- $(MAKE) start-email
	- $(MAKE) start-open-webui
	- $(MAKE) start-db
	- $(MAKE) start-livekit-redis
	- $(MAKE) start-ntfy
	- $(MAKE) start-sip
	- $(MAKE) rustdesk-backup-to-storage-vps
	- $(MAKE) start-rustdesk
	- $(MAKE) synapse-vacuum-clean
	- $(MAKE) synapse-backup-database
	- $(MAKE) synapse-backup-to-storage-vps
	- $(MAKE) start-coturn
	- $(MAKE) start-livekit
	- $(MAKE) start-matrix-rtc
	- $(MAKE) start-synapse
# 	- $(MAKE) start-demo
	- $(MAKE) start-nginx

stop-containers:
	- $(MAKE) stop-nginx
# 	- $(MAKE) stop-demo
	- $(MAKE) stop-synapse
	- $(MAKE) stop-matrix-rtc
	- $(MAKE) stop-livekit
	- $(MAKE) stop-coturn
	- $(MAKE) stop-rustdesk
	- $(MAKE) stop-sip
	- $(MAKE) stop-ntfy
	- $(MAKE) stop-livekit-redis
	- $(MAKE) stop-db
	- $(MAKE) stop-open-webui
	- $(MAKE) stop-email
