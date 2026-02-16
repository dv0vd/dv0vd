# Dv0vD
## https://dv0vd.dev
My personal website to showcase my portfolio, skills, hobbies, and contact information. Additionally, the site features deployed servers for SOCKS4, SOCKS5, HTTPS proxy, Outline VPN, VLESS + XTLS / Reality, Synapse, TURN (Coturn), Matrix (Synapse), Pi-hole, DNS over HTTPS, and Email services.

## Getting started  
1) Update packages index: `apt update`.
2) Install git: `apt install git`.
3) Copy storage-vps SSH private key to `/root/.ssh/vps-storage` for storage vps backups.
4) Clone repo: `git clone https://github.com/dv0vd/dv0vd.git`.
5) Go to the project directory: `cd ./dv0vd`.
6) Configure the `.env` file.
7) Copy Podman images to `./deployment/images`:
- coturn_4.7.0.tar
- dv0vd-demo-skillnotes_1.0.10.tar
- dv0vd-demo-timers_1.0.5.tar
- dv0vd-demo-todo-manager_1.1.1.tar
- dv0vd-https-proxy_1.2.0.tar
- dv0vd-socks4_1.1.3.tar
- dv0vd-socks5_1.1.1.tar
- mongo_7.0.16.tar
- nginx_1.27.3.tar
- outline-shadowbox_v1.12.3.tar
- postgres_15.14-alpine.tar
- synapse_1.135.0.tar
- teddysun_xray-25.10.15.tar
- certbot_5.3.1.tar
- /binwiederhier-ntfy_2.17.tar
8) Run the initialization script `chmod +x ./deployment/init.sh && ./deployment/init.sh`.
