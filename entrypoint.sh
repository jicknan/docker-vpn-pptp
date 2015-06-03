#!/bin/sh

set -e

# start logging
service rsyslog start

# enable IP forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

sysctl -p

# configure firewall
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save
#iptables -A FORWARD -s 10.99.99.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356

exec "$@"
