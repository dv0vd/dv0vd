open-webui-backup-to-storage-vps:
	- rclone sync -v '/root/dv0vd/deployment/data/open-webui' 'vps-storage-bg-open-webui:/'

open-webui-restore-from-storage-vps:
	- rclone sync -v 'vps-storage-bg-open-webui:/' '/root/dv0vd/deployment/restore/open-webui'

