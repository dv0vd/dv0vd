logs-socks4:
	podman logs -f socks4

logs-socks5:
	tail -f -n +1 deployment/data/socks5/logs/danted.log

logs-https-proxy:
	podman logs -f https-proxy

logs-nginx:
	podman logs -f nginx

logs-nginx-access:
	tail -f -n +1 deployment/data/nginx/logs/access.log

logs-nginx-error:
	tail -f -n +1 deployment/data/nginx/logs/error.log

logs-mongo-demo:
	podman logs -f mongo-demo

logs-postgres-demo:
	podman logs -f postgres-demo

logs-timers:
	podman logs -f timers_app

logs-skillnotes:
	podman logs -f skillnotes_app

logs-fail2ban:
	tail -f -n +1 /var/log/fail2ban.log

logs-auth:
	journalctl -u ssh -n 10000 -f