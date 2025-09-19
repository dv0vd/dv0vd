#!/bin/bash
set -e

LOG_FILE="/var/log/init.log"

# Function for logging both to console and to file with separator
log() {
  local msg="$1"
  local ts
  ts=$(date +"%F %T")
  local line="===================================================================="
  echo -e "\n$line" | tee -a "$LOG_FILE"
  echo "[INIT][$ts] $msg" | tee -a "$LOG_FILE"
  echo "$line" | tee -a "$LOG_FILE"
}

log "Loading environment variables..."
set -a &&
source .env &&
set +a &&

log "Setting timezone to UTC..."
timedatectl set-timezone UTC &&

log "Updating system and installing required packages..."
apt update &&
apt upgrade -y &&
apt install -y make &&
apt install -y git && 
apt install -y cgroup-tools &&
apt install -y apache2-utils && # for nginx basic auth
apt install -y fail2ban &&
apt install -y podman && 
#apt install -y telnet &&

log "Configuring SSH..."
cat /root/dv0vd.xyz/deployment/configs/linux/ssh.pub >> /root/.ssh/authorized_keys &&
touch /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo Port $SSH_PORT >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&
envsubst < ./deployment/configs/linux/ssh_env.conf > /root/.ssh/config &&
chmod 600 /root/.ssh/config &&

log "Configuring fail2ban..."
envsubst < /root/dv0vd.xyz/deployment/configs/fail2ban/jail_env.local > /root/dv0vd.xyz/deployment/configs/fail2ban/jail.local &&
cp /root/dv0vd.xyz/deployment/configs/fail2ban/jail.local /etc/fail2ban/jail.local &&
cp /root/dv0vd.xyz/deployment/configs/fail2ban/fail2ban.local /etc/fail2ban/fail2ban.local &&
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/danted.conf /etc/fail2ban/filter.d && 
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/nginx-bad-request.local /etc/fail2ban/filter.d && 
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/nginx-not-found.local /etc/fail2ban/filter.d && 
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/nginx-redirected.local /etc/fail2ban/filter.d && 
touch /root/dv0vd.xyz/deployment/data/nginx/logs/error.log &&
touch /root/dv0vd.xyz/deployment/data/nginx/logs/access.log &&
touch /root/dv0vd.xyz/deployment/data/socks5/logs/danted.log &&
systemctl enable fail2ban &&
systemctl start fail2ban &&

log "Configuring Podman..."
# apt install -y pipx && 
# pipx install podman-compose &&
# pipx ensurepath &&
systemctl enable podman &&
systemctl start podman &&
podman system prune --all -f &&
systemctl set-property podman-group.slice MemoryMax=$PODMAN_MEMORY_LIMIT CPUQuota=$PODMAN_CPUS &&
systemctl stop systemd-resolved && # required for Pi-hole
systemctl disable systemd-resolved && # required for Pi-hole

log "Configuring rclone..."
mkdir -p /root/.config/rclone &&
touch /root/.config/rclone/rclone.conf &&
envsubst < ./deployment/configs/linux/rclone_env.conf > /root/.config/rclone/rclone.conf &&
ssh-keygen -R $RCLONE_HOST || true &&
ssh-keyscan -p $RCLONE_PORT $RCLONE_HOST >> /root/.ssh/known_hosts &&

log "Configuring nginx (htpasswd and SSL certificate)..."
htpasswd -cb /root/dv0vd.xyz/deployment/configs/nginx/.htpasswd $NGINX_BASIC_AUTH_USERNAME $NGINX_BASIC_AUTH_PASSWORD &&
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /root/dv0vd.xyz/deployment/configs/nginx/nginx.key \
  -out /root/dv0vd.xyz/deployment/configs/nginx/nginx.crt \
  -subj "/CN=localhost" &&

log "Configuring rc.local autostart..."
rm /etc/rc.local -f &&
cp /root/dv0vd.xyz/deployment/configs/linux/rc.local /etc/rc.local &&
chmod a+x /etc/rc.local &&

log "Initialization finished. Rebooting now..."
reboot
