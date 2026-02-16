GREEN='\033[1;32m'
WHITE='\033[1;37m'
RESET='\033[0m'
help:
	@echo ${GREEN}start-containers'                        '${WHITE}— start all containers${RESET}
	@echo ${GREEN}start-socks4'                            '${WHITE}— start socks4 server${RESET}
	@echo ${GREEN}start-socks5'                            '${WHITE}— start socks5 server${RESET}
	@echo ${GREEN}start-https-proxy'                       '${WHITE}— start https proxy server${RESET}
	@echo ${GREEN}start-outline'                           '${WHITE}— start outline vpn${RESET}
	@echo ${GREEN}start-xray-vless-reality'                '${WHITE}— start VLESS + XTLS / Reality${RESET}
	@echo ${GREEN}start-nginx'                             '${WHITE}— start nginx server${RESET}
	@echo ${GREEN}start-pihone'                            '${WHITE}— start Pi-hole${RESET}
	@echo ${GREEN}start-doh-server'                        '${WHITE}— start DoH server${RESET}
	@echo ${GREEN}start-ntfy'                              '${WHITE}— start ntfy server${RESET}
	@echo ${GREEN}start-db'                                '${WHITE}— start databases${RESET}
	@echo ${GREEN}start-mongo-demo'                        '${WHITE}— start mongo database for demo projects${RESET}
	@echo ${GREEN}start-postgres-demo'                     '${WHITE}— start postgres database for demo projects${RESET}
	@echo ${GREEN}start-postgres-synapse'                  '${WHITE}— start postgres database for synapse server${RESET}
	@echo ${GREEN}start-demo'                              '${WHITE}— start all demo projects${RESET}
	@echo ${GREEN}start-timers'                            '${WHITE}— start timers demo project${RESET}
	@echo ${GREEN}start-skillnotes'                        '${WHITE}— start skillnotes demo project${RESET}
	@echo ${GREEN}start-todo-manager'                      '${WHITE}— start todo manager demo project${RESET}
	@echo ${GREEN}start-fail2ban'                          '${WHITE}— start fail2ban${RESET}
	@echo ${GREEN}stop-containers'                         '${WHITE}— stop all containers${RESET}
	@echo ${GREEN}stop-socks4'                             '${WHITE}— stop socks4 server${RESET}
	@echo ${GREEN}stop-socks5'                             '${WHITE}— stop socks5 server${RESET}
	@echo ${GREEN}stop-https-proxy'                        '${WHITE}— stop https proxy server${RESET}
	@echo ${GREEN}stop-outline'                            '${WHITE}— stop outline vpn${RESET}
	@echo ${GREEN}stop-xray-vless-reality'                 '${WHITE}— stop VLESS + XTLS / Reality${RESET}
	@echo ${GREEN}stop-pihole'                             '${WHITE}— stop Pi-hole${RESET}
	@echo ${GREEN}stop-doh-server'                         '${WHITE}— stop DoH server${RESET}
	@echo ${GREEN}stop-ntfy'                               '${WHITE}— stop ntfy server${RESET}
	@echo ${GREEN}stop-nginx'                              '${WHITE}— stop nginx server${RESET}
	@echo ${GREEN}stop-db'                                 '${WHITE}— stop databases${RESET}
	@echo ${GREEN}stop-mongo-demo'                         '${WHITE}— stop mongo database for demo projects${RESET}
	@echo ${GREEN}stop-postgres-demo'                      '${WHITE}— stop postgres database for demo projects${RESET}
	@echo ${GREEN}stop-postgres-synapse'                   '${WHITE}— stop postgres database for synapse server${RESET}
	@echo ${GREEN}stop-demo'                               '${WHITE}— stop all demo projects${RESET}
	@echo ${GREEN}stop-timers'                             '${WHITE}— stop timers demo project${RESET}
	@echo ${GREEN}stop-skillnotes'                         '${WHITE}— stop skillnotes demo project${RESET}
	@echo ${GREEN}stop-todo-manager'                       '${WHITE}— stop todo-manager demo project${RESET}
	@echo ${GREEN}stop-fail2ban'                           '${WHITE}— stop fail2ban${RESET}
	@echo ${GREEN}restart-containers'                      '${WHITE}— restart all containers${RESET}
	@echo ${GREEN}restart-socks4'                          '${WHITE}— restart socks4 server${RESET}
	@echo ${GREEN}restart-socks5'                          '${WHITE}— restart socks5 server${RESET}
	@echo ${GREEN}restart-https-proxy'                     '${WHITE}— restart https proxy server${RESET}
	@echo ${GREEN}restart-outline'                         '${WHITE}— restart outline vpn${RESET}
	@echo ${GREEN}restart-xray-vless-reality'              '${WHITE}— restart VLESS + XTLS / Reality${RESET}
	@echo ${GREEN}restart-nginx'                           '${WHITE}— restart nginx server${RESET}
	@echo ${GREEN}restart-pihole'                          '${WHITE}— restart Pi-hole${RESET}
	@echo ${GREEN}restart-doh-server'                      '${WHITE}— restart DoH server${RESET}
	@echo ${GREEN}restart-ntfy'                            '${WHITE}— restart ntfy server${RESET}
	@echo ${GREEN}restart-db'                              '${WHITE}— restart databases${RESET}
	@echo ${GREEN}restart-mongo-demo'                      '${WHITE}— restart mongo database for demo projects${RESET}
	@echo ${GREEN}restart-postgres-demo'                   '${WHITE}— restart postgres database for demo projects${RESET}
	@echo ${GREEN}restart-postgres-synapse'                '${WHITE}— restart postgres database for synapse server${RESET}
	@echo ${GREEN}restart-demo'                            '${WHITE}— restart all demo projects${RESET}
	@echo ${GREEN}restart-timers'                          '${WHITE}— restart timers demo project${RESET}
	@echo ${GREEN}restart-skillnotes'                      '${WHITE}— restart skillnotes demo project${RESET}
	@echo ${GREEN}restart-todo-manager'                    '${WHITE}— restart todo-manager demo project${RESET}
	@echo ${GREEN}enter-nginx'                             '${WHITE}— enter to the nginx container${RESET}
	@echo ${GREEN}enter-synapse'                           '${WHITE}— enter to the synapse container${RESET}
	@echo ${GREEN}enter-outline'                           '${WHITE}— enter to the outline container${RESET}
	@echo ${GREEN}enter-doh-server'                        '${WHITE}— enter to the DoH server container${RESET}
	@echo ${GREEN}restart-fail2ban'                        '${WHITE}— restart fail2ban and reload fail2ban-client${RESET}
	@echo ${GREEN}logs-clear'                              '${WHITE}— clear journalctl logs olden then 1 day${RESET}
	@echo ${GREEN}logs-socks4'                             '${WHITE}— get socks4 server logs${RESET}
	@echo ${GREEN}logs-socks5'                             '${WHITE}— get socks5 server logs${RESET}
	@echo ${GREEN}logs-https-proxy'                        '${WHITE}— get https proxy server logs${RESET}
	@echo ${GREEN}logs-outline'                            '${WHITE}— get outline vpn logs${RESET}
	@echo ${GREEN}logs-xray-vless-reality'                 '${WHITE}— get VLESS + XTLS / Reality logs${RESET}
	@echo ${GREEN}logs-nginx'                              '${WHITE}— get nginx logs${RESET}
	@echo ${GREEN}logs-nginx-access'                       '${WHITE}— get nginx access logs${RESET}
	@echo ${GREEN}logs-nginx-error'                        '${WHITE}— get nginx error logs${RESET}
	@echo ${GREEN}logs-pihole'                             '${WHITE}— get Pi-hole logs${RESET}
	@echo ${GREEN}logs-doh-server'                         '${WHITE}— get DoH server logs${RESET}
	@echo ${GREEN}logs-ntfy'                               '${WHITE}— get ntfy server logs${RESET}
	@echo ${GREEN}logs-mongo-demo'                         '${WHITE}— get logs of mongo database for demo projects${RESET}
	@echo ${GREEN}logs-postgres-demo'                      '${WHITE}— get logs of postgres database for demo projects${RESET}
	@echo ${GREEN}logs-postgres-synapse'                   '${WHITE}— get logs of postgres database for synapse server${RESET}
	@echo ${GREEN}logs-timers'                             '${WHITE}— get logs of timers demo project${RESET}
	@echo ${GREEN}logs-skillnotes'                         '${WHITE}— get logs of skillnotes demo project${RESET}
	@echo ${GREEN}logs-todo-manager'                       '${WHITE}— get logs of todo-manager demo project${RESET}
	@echo ${GREEN}logs-auth'                               '${WHITE}— get SSH connection attemps logs${RESET}
	@echo ${GREEN}logs-init'                               '${WHITE}— get init logs${RESET}
	@echo ${GREEN}logs-startup'                            '${WHITE}— get startup logs${RESET}
	@echo ${GREEN}logs-fail2ban'                           '${WHITE}— get fail2ban logs${RESET}
	@echo ${GREEN}logs-synapse'                            '${WHITE}— get synapse homerver logs${RESET}
	@echo ${GREEN}logs-synapse-container'                  '${WHITE}— get synapse container logs${RESET}
	@echo ${GREEN}fail2ban-status'                         '${WHITE}— get fail2ban jails status${RESET}
	@echo ${GREEN}fail2ban-unban-all'                      '${WHITE}— unban all IPs in fail2ban${RESET}
	@echo ${GREEN}podman-load-images'                      '${WHITE}— load images from local copy${RESET}
	@echo ${GREEN}podman-cleanup'                          '${WHITE}— clean all podman resources${RESET}
	@echo ${GREEN}podman-create-network'                   '${WHITE}— create custom podman network with ipv6 support${RESET}
	@echo ${GREEN}podman-stats'                            '${WHITE}— get containers stats${RESET}
	@echo ${GREEN}podman-info'                             '${WHITE}— get containers list with info${RESET}
	@echo ${GREEN}podman-resources'                        '${WHITE}— get podman consumed resources with tasks${RESET}
	@echo ${GREEN}iptables-rules-filter'                   '${WHITE}— show iptables filter table rules${RESET}
	@echo ${GREEN}iptables-rules-nat'                      '${WHITE}— show iptables nat table rules${RESET}
	@echo ${GREEN}iptables-rules-mangle'                   '${WHITE}— show iptables raw table rules${RESET}
	@echo ${GREEN}iptables-rules-raw'                      '${WHITE}— show iptables mangle table rules{$RESET}
	@echo ${GREEN}ip6tables-rules-filter'                  '${WHITE}— show ip6tables filter table rules${RESET}
	@echo ${GREEN}ip6tables-rules-nat'                     '${WHITE}— show ip6tables nat table rules${RESET}
	@echo ${GREEN}ip6tables-rules-mangle'                  '${WHITE}— show ip6tables raw table rules${RESET}
	@echo ${GREEN}ip6tables-rules-raw'                     '${WHITE}— show ip6tables mangle table rules${RESET}
	@echo ${GREEN}iptables-rules-apply'                    '${WHITE}— apply iptables rules${RESET}
	@echo ${GREEN}on-startup'                              '${WHITE}— commands to execute immediately after server startup${RESET}
	@echo ${GREEN}disable-ipv6'                            '${WHITE}— disable-ipv6${RESET}
	@echo ${GREEN}init-demo'                               '${WHITE}— clone demo projects and install dependencies${RESET}
	@echo ${GREEN}init-lagoona'                            '${WHITE}— clone lagoona demo project and install dependencies${RESET}
	@echo ${GREEN}init-evklid'                             '${WHITE}— clone evklid demo project and install dependencies${RESET}
	@echo ${GREEN}init-gazprombank-auth'                   '${WHITE}— clone gazprombank auth demo project and install dependencies${RESET}
	@echo ${GREEN}init-gazprombank-startups'               '${WHITE}— clone gazprombank startups form project and install dependencies${RESET}
	@echo ${GREEN}refresh-demo'                            '${WHITE}— completely remove demo projects and reinstall them${RESET}
	@echo ${GREEN}refresh-lagoona'                         '${WHITE}— completely remove lagoona project and reinstall it${RESET}
	@echo ${GREEN}refresh-evklid'                          '${WHITE}— completely remove evklid project and reinstall it${RESET}
	@echo ${GREEN}refresh-gazprombank-auth'                '${WHITE}— completely remove gazprombank auth project and reinstall it${RESET}
	@echo ${GREEN}refresh-gazprombank-startups'            '${WHITE}— completely remove gazprombank startup form project and reinstall it${RESET}
	@echo ${GREEN}synapse-init'                            '${WHITE}— init synapse server${RESET}
	@echo ${GREEN}synapse-create-user'                     '${WHITE}— create synapse user${RESET}
	@echo ${GREEN}synapse-vacuum-clean'                    '${WHITE}— reclaims synapse postgres space${RESET}
	@echo ${GREEN}synapse-backup-database'                 '${WHITE}— backup synapse postgres database${RESET}
	@echo ${GREEN}synapse-restore-database'                '${WHITE}— restore synapse postgres database${RESET}
	@echo ${GREEN}synapse-backup-to-storage-vps'           '${WHITE}— backup synapse database and media store to storage vps${RESET}
	@echo ${GREEN}synapse-restore-from-storage-vps'        '${WHITE}— restore synapse database and media store from storage vps${RESET}
	@echo ${GREEN}outline-get-keys'                        '${WHITE}— get outline vpn client keys${RESET}
	@echo ${GREEN}outline-create-key' [name]               '${WHITE}— create outline vpn client key${RESET}
	@echo ${GREEN}outline-delete-key' [id]                 '${WHITE}— delete outline vpn client key${RESET}
	@echo ${GREEN}generate-xray-private-key'               '${WHITE}— generate VLESS + XTLS / Reality private key${RESET}
	@echo ${GREEN}generate-xray-short-id'                  '${WHITE}— generate VLESS + XTLS / Reality shortId${RESET}
	@echo ${GREEN}letsencrypt-issue-certificates'           '${WHITE}— issue Lets enctypt certificates${RESET}
	@echo ${GREEN}letsencrypt-renew-certificates'           '${WHITE}— renew Lets enctypt certificates${RESET}
