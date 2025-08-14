GREEN='\033[1;32m'
WHITE='\033[1;37m'
help:
	@echo ${GREEN}start-containers'             '${WHITE}— start all containers
	@echo ${GREEN}start-socks4'                 '${WHITE}— start socks4 server
	@echo ${GREEN}start-socks5'                 '${WHITE}— start socks5 server
	@echo ${GREEN}start-https-proxy'            '${WHITE}— start https proxy server
	@echo ${GREEN}start-nginx'                  '${WHITE}— start nginx server
	@echo ${GREEN}start-db'                     '${WHITE}— start databases
	@echo ${GREEN}start-mongo-demo'             '${WHITE}— start mongo database for demo projects
	@echo ${GREEN}start-postgres-demo'          '${WHITE}— start postgres database for demo projects
	@echo ${GREEN}start-postgres-synapse'       '${WHITE}— start postgres database for synapse server
	@echo ${GREEN}start-demo'                   '${WHITE}— start all demo projects
	@echo ${GREEN}start-timers'                 '${WHITE}— start timers demo project
	@echo ${GREEN}start-skillnotes'             '${WHITE}— start skillnotes demo project
	@echo ${GREEN}start-fail2ban'               '${WHITE}— start fail2ban
	@echo ${GREEN}stop-containers'              '${WHITE}— stop all containers
	@echo ${GREEN}stop-socks4'                  '${WHITE}— stop socks4 server
	@echo ${GREEN}stop-socks5'                  '${WHITE}— stop socks5 server
	@echo ${GREEN}stop-https-proxy'             '${WHITE}— stop https proxy server
	@echo ${GREEN}stop-nginx'                   '${WHITE}— stop nginx server
	@echo ${GREEN}stop-db'                      '${WHITE}— stop databases
	@echo ${GREEN}stop-mongo-demo'              '${WHITE}— stop mongo database for demo projects
	@echo ${GREEN}stop-postgres-demo'           '${WHITE}— stop postgres database for demo projects
	@echo ${GREEN}stop-postgres-synapse'        '${WHITE}— stop postgres database for synapse server
	@echo ${GREEN}stop-demo'                    '${WHITE}— stop all demo projects
	@echo ${GREEN}stop-timers'                  '${WHITE}— stop timers demo project
	@echo ${GREEN}stop-skillnotes'              '${WHITE}— stop skillnotes demo project
	@echo ${GREEN}stop-fail2ban'                '${WHITE}— stop fail2ban
	@echo ${GREEN}restart-containers'           '${WHITE}— restart all containers
	@echo ${GREEN}restart-socks4'               '${WHITE}— restart socks4 server
	@echo ${GREEN}restart-socks5'               '${WHITE}— restart socks5 server
	@echo ${GREEN}restart-https-proxy'          '${WHITE}— restart https proxy server
	@echo ${GREEN}restart-nginx'                '${WHITE}— restart nginx server
	@echo ${GREEN}restart-db'                   '${WHITE}— restart databases
	@echo ${GREEN}restart-mongo-demo'           '${WHITE}— restart mongo database for demo projects
	@echo ${GREEN}restart-postgres-demo'        '${WHITE}— restart postgres database for demo projects
	@echo ${GREEN}restart-postgres-synapse'     '${WHITE}— restart postgres database for synapse server
	@echo ${GREEN}restart-demo'                 '${WHITE}— restart all demo projects
	@echo ${GREEN}restart-timers'               '${WHITE}— restart timers demo project
	@echo ${GREEN}restart-skillnotes'           '${WHITE}— restart skillnotes demo project
	@echo ${GREEN}restart-fail2ban'             '${WHITE}— restart fail2ban and reload fail2ban-client
	@echo ${GREEN}logs-socks4'                  '${WHITE}— get socks4 server logs
	@echo ${GREEN}logs-socks5'                  '${WHITE}— get socks5 server logs
	@echo ${GREEN}logs-https-proxy'             '${WHITE}— get https proxy server logs
	@echo ${GREEN}logs-nginx'                   '${WHITE}— get nginx logs
	@echo ${GREEN}logs-nginx-access'            '${WHITE}— get nginx access logs
	@echo ${GREEN}logs-nginx-error'             '${WHITE}— get nginx error logs
	@echo ${GREEN}logs-mongo-demo'              '${WHITE}— get logs of mongo database for demo projects  
	@echo ${GREEN}logs-postgres-demo'           '${WHITE}— get logs of postgres database for demo projects 
	@echo ${GREEN}logs-postgres-synapse'        '${WHITE}— get logs of postgres database for synapse server 
	@echo ${GREEN}logs-timers'                  '${WHITE}— get logs of timers demo project
	@echo ${GREEN}logs-skillnotes'              '${WHITE}— get logs of skillnotes demo project
	@echo ${GREEN}logs-auth'                    '${WHITE}— get SSH connection attemps logs
	@echo ${GREEN}logs-fail2ban'                '${WHITE}— get fail2ban logs
	@echo ${GREEN}fail2ban-status'              '${WHITE}— get fail2ban jails status
	@echo ${GREEN}fail2ban-unban-all'           '${WHITE}— unban all IPs in fail2ban
	@echo ${GREEN}podman-load-images'           '${WHITE}— load images from local copy
	@echo ${GREEN}podman-cleanup'               '${WHITE}— clean all podman resources
	@echo ${GREEN}podman-create-network'        '${WHITE}— create custom podman network with ipv6 support
	@echo ${GREEN}podman-stats'                 '${WHITE}— get containers stats
	@echo ${GREEN}podman-info'                  '${WHITE}— get containers list with info
	@echo ${GREEN}schedule-midnight-reboot'     '${WHITE}— reboot server at midnight
	@echo ${GREEN}init-demo'                    '${WHITE}— clone demo projects and install dependencies
	@echo ${GREEN}refresh-demo'                 '${WHITE}— completely remove demo projects and reinit them
	@echo ${GREEN}init-demo'                    '${WHITE}— clone timers demo project and install dependencies
	@echo ${GREEN}init-demo'                    '${WHITE}— clone timers demo project and install dependencies
	@echo ${GREEN}clear-logs'                   '${WHITE}— clear journalctl logs olden then 1 day

# @echo ${GREEN} fail2ban-ssh                            '${WHITE}— ssh blocked ips
# @echo ${GREEN} podman-cleanup                            '${WHITE}— podman cleaning