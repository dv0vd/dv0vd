#!/bin/bash

iptables -F # clean all rules
iptables -X # clean all user defined chains

# default policies
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

# allow localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # allow established/related

# block ips
ipset create blocked_hosts iphash -exist # no error if set already exists
ipset -F blocked_hosts # clean set
for ip in $(cat ./deployment/configs/iptables/blocked_hosts.txt); do
    ipset add blocked_hosts $ip
done
iptables -A INPUT -p tcp -m set --match-set blocked_hosts src -j REJECT --reject-with tcp-reset
iptables -A INPUT -p udp -m set --match-set blocked_hosts src -j REJECT --reject-with icmp-port-unreachable

# allow podman
iptables -A FORWARD -o podman1 -j ACCEPT
iptables -A FORWARD -i podman1 -j ACCEPT

# allow icmp
iptables -A INPUT -p icmp --icmp-type 8 -m limit --limit 10/s -j ACCEPT # echo request with limit for the whole server
iptables -A OUTPUT -p icmp --icmp-type 0 -m limit --limit 10/s -j ACCEPT # echo reply with limit for the whole server

iptables -A INPUT -p tcp --dport $SSH_PORT -j ACCEPT # allow SSH

# drop invalid packages
iptables -A INPUT  -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP

# default rules
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
