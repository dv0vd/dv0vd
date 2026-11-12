restore:
	- $(MAKE) stop-containers
	- $(MAKE) restore-clean
	- $(MAKE) email-restore-from-storage-vps
	- $(MAKE) rustdesk-restore-from-storage-vps
	- $(MAKE) open-webui-restore-from-storage-vps
	- $(MAKE) synapse-restore-from-storage-vps
	- mkdir -p ./deployment/data/synapse/data/media_store
	- cp -a ./deployment/restore/open-webui/. ./deployment/data/open-webui/
	- cp -a ./deployment/restore/rustdesk/. ./deployment/data/rustdesk/
	- cp -a ./deployment/restore/email/configs/. ./deployment/data/email/configs/
	- cp -a ./deployment/restore/email/data/. ./deployment/data/email/data/
	- cp -a ./deployment/restore/email/logs/. ./deployment/data/email/logs/
	- cp -a ./deployment/restore/email/state/. ./deployment/data/email/state/
	- cp -a ./deployment/restore/synapse/. ./deployment/data/synapse/data/media_store/
	- cp -a ./deployment/restore/postgres-synapse/. ./deployment/data/postgres-synapse/backups/
	- $(MAKE) start-postgres-synapse
	- $(MAKE) synapse-restore-database

restore-clean:
	find ./deployment/restore -mindepth 2 ! -name '.gitignore' -delete
