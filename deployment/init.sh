# timezone
timedatectl set-timezone UTC &&

#apt
apt update &&
apt upgrade &&
apt install -y make &&
#apt install -y net-tools &&
#apt install -y cron &&

#ssh
cat /root/deployment/configs/linux/ssh.pub >> /root/.ssh/authorized_keys &&
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config &&
echo 'Port 60000' >> /etc/ssh/sshd_config &&

# ipv6
#sed -i '/GRUB_CMDLINE_LINUX=/ s/"$/ ipv6.disable=1"/g' /etc/default/grub &&
#update-grub &&

# fail2ban
apt install fail2ban -y &&
cat /root/deployment/configs/fail2ban/jail.local >> /etc/fail2ban/jail.local &&
cat /root/deployment/configs/fail2ban/fail2ban.local >> /etc/fail2ban/fail2ban.local &&
systemctl enable fail2ban &&
systemctl start fail2ban &&

#podman
apt install podman -y && 
systemctl enable podman &&
systemctl start podman &&
podman system prune --all -f &&
rm /etc/rc.local -f &&
touch /etc/rc.local &&
echo '#!/bin/bash' >> /etc/rc.local &&
echo 'cd /root' >> /etc/rc.local &&
echo 'make restart-containers' >> /etc/rc.local &&
echo 'make schedule-midnight-reboot' >> /etc/rc.local &&
echo 'exit 0' >> /etc/rc.local &&
chmod a+x /etc/rc.local &&


# ufw
#apt install ufw &&
#ufw default deny incoming &&
#ufw default deny outgoing &&
#ufw default allow routed &&
#ufw allow 60000 &&
#ufw enable

#apt install ufw &&
#ufw default allow incoming &&
#ufw default allow outgoing &&
#ufw default allow routed &&
#ufw allow 60000 &&
#ufw deny from any &&
#ufw deny out to any &&
#ufw enable &&


# finish
reboot





#ufw allow openvpn &&



# new user
#userdel vps;
#adduser vps &&
#usermod -a -G sudo vps &&

#ssh
#mkdir /home/vps/.ssh &&
#chown vps:vps /home/vps/.ssh -R &&
#chmod 700 /home/vps/.ssh &&
#chmod 600 /home/vps/.ssh/authorized_keys &&



#--privileged 


#echo 'DenyUsers root' >> /etc/ssh/sshd_config &&
#    --cap-add=net_admin,net_raw \
#adduser slava --disabled-password --gecos '' &&
#usermod -a -G sudo slava &&
#echo 'slava:fRwwiXY7L3P44oZEATkvtz7yrqIYP9ku' | chpasswd &&
#userdel--remove  slava
#groupdel  slava

#cat ~/.ssh/vps.pub >> /home/slava/.ssh/authorized_keys &&
#ssh-copy-id -i ~/.ssh/id_rsa.pub slava@localhost

#cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
#fail2ban-client unban --all



# openvpn
# mkdir /root/_data/openvpn -p &&
# mkdir /root/_data/openvpn/certificates &&
# podman load < /root/deployment/openvpn/kylemanna-openvpn_edge.tar &&
#podman run \
#    -v /root/_data/openvpn:/etc/openvpn \
#    --name=ovpn_genconfig \
#    docker.io/kylemanna/openvpn:edge \
#    ovpn_genconfig -u udp://dv0vd.xyz &&
#podman run \
#    -v /root/_data/openvpn:/etc/openvpn \
#    --name=ovpn_initpki \
#    -it \
#    docker.io/kylemanna/openvpn:edge \
#    ovpn_initpki &&
#podman stop ovpn_genconfig;
#podman stop ovpn_initpki;
#podman rm ovpn_genconfig; 
#podman rm ovpn_initpki; 
