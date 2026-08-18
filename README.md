# Dv0vD
## https://dv0vd.dev
Personal website presenting portfolio, technical skills, interests, and contact information, along with hosted infrastructure: SOCKS4/5, HTTPS, and MTProto proxies, Outline VPN, VLESS+XTLS/Reality, Matrix (Synapse), TURN (Coturn), ntfy, LiveKit, Pi-hole, DNS-over-HTTPS, RustDesk, and email services.

## Getting started  
1) Update packages index: `apt update`.
2) Install git: `apt install git`.
3) Clone repo: `git clone https://github.com/dv0vd/dv0vd.git`.
4) Go to the project directory: `cd ./dv0vd`
5) Go to the `lite` branch: `git checkout lite`.
6) Configure the `.env` file.
7) Copy Podman images to `./deployment/images`:
- dv0vd-https-proxy_1.2.0.tar
- dv0vd-socks4_1.1.3.tar
- dv0vd-socks5_1.1.1.tar
- nginx_1.27.3.tar
- outline-shadowbox_v1.12.3.tar
- pihole_2025.08.0.tar
- nineseconds-mtg_2.2.8.tar
8) Run the initialization script `chmod +x ./deployment/init.sh && ./deployment/init.sh`.