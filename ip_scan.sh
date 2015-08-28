#!/bin/sh
# 
# Jeff Wolak
#
# Script to scan all connected networks to create a mapping of IP to MAC addresses
#
# NMAP will output MAC addresses only if run as root (or sudo)
#
# OUTPUT
# 192.168.100.10 00:14:38:BC:3D:94
# 192.168.100.11 00:14:38:BC:3D:95
# 192.168.100.12 00:14:38:BC:3E:32
#

# make sure we are root
if [ $USER != root ]
then
  echo "You must be root to get MAC address info from NMAP"
  exit 1
fi

# Get networks on each interface except loopback
networks=$(/sbin/ip addr show eth0 | grep "inet " | grep -v "host lo" | gawk '{print $2}')


while [ "$networks" != "" ];
do
	set -- $networks
	currentnetwork=$1
	shift
	networks=$@
	nmap -sn -n $currentnetwork | grep -E "report |MAC" | tr "\n" "+" | sed 's/+MAC Address://g' | sed 's/Nmap scan report for //g' | tr "+" "\n" | gawk -F" " '{print $1,$2}'

done

exit 0
