# Dv0vD
## https://dv0vd.xyz
My personal website to showcase my portfolio, skills, hobbies, and contact information. Additionally, the site features deployed servers for SOCKS4, SOCKS5, HTTPS proxy, Synapse, Coturn, Matrix, Pi-hole (Ad Blocking), and Email services.

## Getting started  
1) Update packages index: `apt update`.
2) Install git: `apt install git`.
3) Configure the `.env` file.
4) Copy SSH private key to `../.ssh`.
5) Setup `../.ssh/config` file.
6) Copy Podman images to `./deployment/images`:
- coturn_4.7.0.tar
- dv0vd-https-proxy_1.1.0.tar
- dv0vd-socks4_1.1.3.tar
- dv0vd-socks5_1.1.1.tar
- mongo_7.0.16.tar
- nginx_1.27.3.tar
- node_24.5.0-alpine.tar
- postgres_15.14-alpine.tar
- synapse_1.135.0.tar
7) Run the initialization script `bash ./deployment/init.sh`.
