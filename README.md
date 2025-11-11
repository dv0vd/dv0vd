# Dv0vD
## https://dv0vd.dev
My personal website to showcase my portfolio, skills, hobbies, and contact information. Additionally, the site features deployed servers for SOCKS4, SOCKS5, HTTPS proxy, Outline VPN, Synapse, TURN, Matrix, Pi-hole (Ad Blocking), and Email services.

## Getting started  
1) Update packages index: `apt update`.
2) Install git: `apt install git`.
3) Clone repo: `git clone https://github.com/dv0vd/dv0vd.git`.
4) Go to the `lite` branch: `cd dv0vd && git checkout lite`.
5) Configure the `.env` file.
6) Copy Podman images to `./deployment/images`:
- dv0vd-https-proxy_1.2.0.tar
- dv0vd-socks4_1.1.3.tar
- dv0vd-socks5_1.1.1.tar
- nginx_1.27.3.tar
- outline-shadowbox_v1.12.3.tar
- pihole_2025.08.0.tar
7) Run the initialization script `bash ./deployment/init.sh`.
