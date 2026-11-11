# Dv0vD
## https://dv0vd.dev
Personal website presenting portfolio, technical skills, interests, and contact information, along with hosted infrastructure: SOCKS4/5, HTTPS, MTProto proxies, Outline VPN, VLESS+XTLS/Reality, WebRTC tunneling / whitelist-bypass infrastructure, Matrix (Synapse), TURN (Coturn), ntfy, LiveKit, Pi-hole, DNS-over-HTTPS, RustDesk, Email, SIP services, Open WebUI.

## Getting started  
1) Update packages index: `apt update`.
2) Install git: `apt install git -y`.
3) Clone repo: `git clone -c core.filemode=false https://github.com/dv0vd/dv0vd.git`.
4) Go to the project directory: `cd ./dv0vd`
5) Go to the `proxy` branch: `git switch proxy`.
6) Configure the `.env` file.
7) Run the initialization script `chmod +x ./deployment/init.sh && ./deployment/init.sh`.
