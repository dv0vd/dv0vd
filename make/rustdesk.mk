rustdesk-backup-to-storage-vps:
	- rclone sync -v '/root/dv0vd/deployment/data/rustdesk' 'vps-storage-bg-rustdesk:/'

rustdesk-restore-from-storage-vps:
	- rclone sync -v 'vps-storage-bg-rustdesk:/' '/root/dv0vd/deployment/restore/rustdesk'