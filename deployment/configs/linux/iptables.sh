#!/bin/bash

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

#ipset -F
#ipset -X

iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT  -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP

# iptables -A INPUT  -m state --state ESTABLISHED,RELATED      -j ACCEPT
# iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED  -j ACCEPT

# 9.59
BLOCKED_IPS="<ip1> <ip2>"
for IP in $BLOCKED_IPS
do
    iptables -A INPUT -s $IP -j DROP
done

# limit
# connlimit
# recent match
# ipset autoblock
# reject instead of drop
# disable ip forward?