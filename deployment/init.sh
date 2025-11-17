#!/bin/bash
set -e # stop script on any error



configure_fail2ban() {
  log "Configuring fail2ban..."
  envsubst < /root/dv0vd/deployment/configs/fail2ban/jail_env.local > /root/dv0vd/deployment/configs/fail2ban/jail.local
  cp /root/dv0vd/deployment/configs/fail2ban/jail.local /etc/fail2ban/jail.local
  cp /root/dv0vd/deployment/configs/fail2ban/fail2ban.local /etc/fail2ban/fail2ban.local
  cp /root/dv0vd/deployment/configs/fail2ban/filters/danted.conf /etc/fail2ban/filter.d
  cp /root/dv0vd/deployment/configs/fail2ban/filters/nginx-bad-request.local /etc/fail2ban/filter.d 
  cp /root/dv0vd/deployment/configs/fail2ban/filters/nginx-not-found.local /etc/fail2ban/filter.d
  cp /root/dv0vd/deployment/configs/fail2ban/filters/nginx-redirected.local /etc/fail2ban/filter.d
  touch /root/dv0vd/deployment/data/nginx/logs/error.log
  touch /root/dv0vd/deployment/data/nginx/logs/access.log
  touch /root/dv0vd/deployment/data/socks5/logs/danted.log
  systemctl disable fail2ban
  systemctl start fail2ban
  log "Fail2ban successfully configured"
}

configure_nginx() {
  log "Configuring nginx..."
  htpasswd -cb /root/dv0vd/deployment/configs/nginx/.htpasswd $NGINX_BASIC_AUTH_USERNAME $NGINX_BASIC_AUTH_PASSWORD &&
  openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout /root/dv0vd/deployment/configs/nginx/nginx.key \
    -out /root/dv0vd/deployment/configs/nginx/nginx.crt \
    -subj "/CN=localhost" &&
  log "Nginx successfully configured"
}

configure_ssh() {
  log "Configuring SSH..."
  cat /root/dv0vd/deployment/configs/ssh/ssh.pub >> /root/.ssh/authorized_keys
  touch /etc/ssh/sshd_config.d/00-dv0vd.conf
  echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config.d/00-dv0vd.conf
  echo Port $SSH_PORT >> /etc/ssh/sshd_config.d/00-dv0vd.conf
  envsubst < ./deployment/configs/ssh/ssh_env.conf > /root/.ssh/config
  chmod 600 /root/.ssh/config
  log "SSH successfully generated"
}

configure_outline() {
  log "Configuring Outline VPN..."
  openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout /root/dv0vd/deployment/configs/outline/outline.key \
    -out /root/dv0vd/deployment/configs/outline/outline.crt \
    -subj "/CN=localhost"
  generateOutlineServerConfig
  log "Outline VPN successfully configured"
}

configure_podman() {
  log "Configuring Podman..."
  # apt install -y pipx && 
  # pipx install podman-compose &&
  # pipx ensurepath &&
  systemctl enable podman
  systemctl start podman
  podman system prune --all -f
  systemctl set-property podman-group.slice MemoryMax=$PODMAN_MEMORY_LIMIT CPUQuota=$PODMAN_CPUS
  systemctl stop systemd-resolved # required for Pi-hole
  systemctl disable systemd-resolved # required for Pi-hole
  log "Podman successfully configured"
}

configure_rclone() {
  log "Configuring rclone..."
  mkdir -p /root/.config/rclone
  touch /root/.config/rclone/rclone.conf
  envsubst < ./deployment/configs/rclone/rclone_env.conf > /root/.config/rclone/rclone.conf
  ssh-keygen -R $RCLONE_HOST || true
  ssh-keyscan -p $RCLONE_PORT $RCLONE_HOST >> /root/.ssh/known_hosts
  log "Rclone successfully configured"
}

finish() {
  log "Configuring rc.local autostart..."
  rm /etc/rc.local -f
  cp /root/dv0vd/deployment/configs/linux/rc.local /etc/rc.local
  chmod a+x /etc/rc.local
  log "rc.local autostart successfully configured"
  log "Initialization finished. Rebooting now..."
  reboot
}

generateOutlineServerConfig() {
  log "Generating outline server configuration..."
  serverId=$(uuidgen)
  createdTimestampMs=$(date +%s%3N)
  hostname="localhost"
  portForNewAccessKeys=28085
  metricsEnabled=false
  json=$(jq -n \
    --arg serverId "$serverId" \
    --argjson metricsEnabled "$metricsEnabled" \
    --argjson createdTimestampMs "$createdTimestampMs" \
    --arg hostname "$hostname" \
    --argjson portForNewAccessKeys "$portForNewAccessKeys" \
    '{
        serverId: $serverId,
        metricsEnabled: $metricsEnabled,
        createdTimestampMs: $createdTimestampMs,
        hostname: $hostname,
        portForNewAccessKeys: $portForNewAccessKeys
    }'
  )

  echo "$json" > ./deployment/configs/outline/shadowbox_server_config.json
  log "Outline server configuration successfully generated"
}

install_packages() {
  log "Updating system and installing required packages..."
  apt update
  apt upgrade -y
  apt install -y make
  apt install -y curl
  apt install -y git
  apt install -y cgroup-tools
  apt install -y apache2-utils # for nginx basic auth
  apt install -y fail2ban
  apt install -y podman
  apt install -y iptables
  apt install -y ipset # for iptables
  apt install -y gettext # for envsubst
  apt install -y jq # for outline json config generation
  apt install -y uuid-runtime # for outline json config generation
  apt install dnsutils # for dig
  #apt install -y telnet &&
  log "Packages successfully installed"
}

load_env() {
  log "Loading environment variables..."
  set -a
  source .env
  set +a
  log "Environment variables successfully loaded"
}

log() {
  local log_file="/var/log/init.log"
  local msg="$1"
  local ts
  ts=$(date +"%F %T")
  local line="===================================================================="
  echo -e "\n$line" | tee -a "$log_file"
  echo "[INIT][$ts] $msg" | tee -a "$log_file"
  echo "$line" | tee -a "$log_file"
}

set_timezone() {
  log "Setting timezone to UTC..."
  timedatectl set-timezone UTC
  log "Timezone successfully set"
}

configure_dns() {
  log "Configuring DNS..."
  touch /etc/resolv.conf || true
  echo "nameserver ${DNS1}" > /etc/resolv.conf
	echo "nameserver ${DNS2}" >> /etc/resolv.conf
	echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	echo "nameserver 8.8.8.8" >> /etc/resolv.conf
  log "DNS successfully configured"
}



load_env
set_timezone
install_packages
configure_dns
configure_ssh
configure_fail2ban
configure_podman
configure_rclone
configure_nginx
configure_outline
finish
