logs-socks4:
	podman logs -f socks4

logs-socks5:
	podman logs -f socks5

logs-https-proxy:
	podman logs -f https-proxy

logs-nginx:
	podman logs -f nginx

logs-mongo:
	podman logs -f mongo

logs-postgres:
	podman logs -f postgres

logs-timers:
	podman logs -f timers_app

logs-skillnotes:
	podman logs -f skillnotes_app