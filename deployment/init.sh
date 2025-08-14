# timezone
timedatectl set-timezone UTC &&

#apt
apt update &&
apt upgrade &&
apt install -y make &&
apt install -y git && 
#apt install -y apache2-utils && # for nginx basic auth
#apt install -y telnet &&

#ssh
cat /root/dv0vd.xyz/deployment/configs/linux/ssh.pub >> /root/.ssh/authorized_keys &&
touch /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo Port $SSH_PORT >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&

# fail2ban
apt install fail2ban -y &&
cat /root/dv0vd.xyz/deployment/configs/fail2ban/jail.local >> /etc/fail2ban/jail.local &&
cat /root/dv0vd.xyz/deployment/configs/fail2ban/fail2ban.local >> /etc/fail2ban/fail2ban.local &&
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/danted.conf /etc/fail2ban/filter.d && 
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/nginx-bad-request.local /etc/fail2ban/filter.d && 
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/nginx-not-found.local /etc/fail2ban/filter.d && 
cp /root/dv0vd.xyz/deployment/configs/fail2ban/filters/nginx-redirected.local /etc/fail2ban/filter.d && 
systemctl enable fail2ban &&
systemctl start fail2ban &&

#podman
apt install podman -y && 
apt install -y pipx && 
pipx install podman-compose &&
pipx ensurepath &&
systemctl enable podman &&
systemctl start podman &&
podman system prune --all -f &&
rm /etc/rc.local -f &&
cp /root/dv0vd.xyz/deployment/configs/linux/rc.local /etc/rc.local
chmod a+x /etc/rc.local &&

reboot

