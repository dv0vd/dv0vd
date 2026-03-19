email-init:
	podman run --rm -it \
		-v ./deployment/data/email/configs:/tmp/docker-mailserver \
		ghcr.io/docker-mailserver/docker-mailserver:15.1.0 \
		setup config dkim domain ${BASE_URL}

email-create-user:
	podman run --rm -it \
		-v ./deployment/data/email/configs:/tmp/docker-mailserver \
		ghcr.io/docker-mailserver/docker-mailserver:15.1.0 \
		setup email add ${username}@${BASE_URL}

email-delete-user:
	podman run --rm -it \
		-v ./deployment/data/email/configs:/tmp/docker-mailserver \
		-v ./deployment/data/email/data:/var/mail \
		ghcr.io/docker-mailserver/docker-mailserver:15.1.0 \
		setup email del ${username}@${BASE_URL}

email-list-users:
	podman run --rm -it \
		-v ./deployment/data/email/configs:/tmp/docker-mailserver \
		-e ACCOUNT_PROVISIONER=FILE \
		ghcr.io/docker-mailserver/docker-mailserver:15.1.0 \
		setup email list

email-change-password:
	podman run --rm -it \
		-v ./deployment/data/email/configs:/tmp/docker-mailserver \
		-v ./deployment/data	/email/data:/var/mail \
		ghcr.io/docker-mailserver/docker-mailserver:15.1.0 \
		setup email update ${username}@${BASE_URL}	

email-backup-to-storage-vps:
	- rclone sync -v '/root/dv0vd/deployment/data/email' 'vps-storage-bg-email:/'

email-restore-from-storage-vps:
	- rclone sync -v 'vps-storage-bg-email:/' '/root/dv0vd/deployment/restore/email'
