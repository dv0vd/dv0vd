# Dv0vD
## https://dv0vd.dev
My personal website to showcase my portfolio, skills, hobbies, and contact information. Additionally, the site features deployed servers for SOCKS4, SOCKS5, HTTPS proxy, Synapse, TURN, Matrix, Pi-hole (Ad Blocking), and Email services.

## Getting started  
1) Update packages index: `apt update`.
2) Install git: `apt install git`.
3) Copy storage-vps SSH private key to `/root/.ssh/vps-storage` for storage vps backups.
4) Clone repo: `git clone https://github.com/dv0vd/dv0vd.git`.
5) Copy Nginx certificates to `./deployment/configs/nginx`:
- dv0vd_xyz.crt
- dv0vd_xyz.key
6) Configure the `.env` file.
7) Copy Podman images to `./deployment/images`:
- coturn_4.7.0.tar
- dv0vd-https-proxy_1.2.0.tar
- dv0vd-socks4_1.1.3.tar
- dv0vd-socks5_1.1.1.tar
- mongo_7.0.16.tar
- nginx_1.27.3.tar
- node_24.5.0-alpine.tar
- postgres_15.14-alpine.tar
- synapse_1.135.0.tar
- pihole_2025.08.0.tar
- dv0vd-demo-skillnotes_1.0.6.tar
8) Run the initialization script `bash ./deployment/init.sh`.
