#!/bin/sh
# *******************************************
# Jeffrey Wolak
# Script to check IP address and change the
# location to match "Home" or "Work"
# *******************************************

# Get the IP address
address=`/sbin/ifconfig | awk -F" " '/broadcast/{print $2}'`
firstOctet=`echo $address | awk -F"." '{print $1}'`

# Check the Location
if [ "$firstOctet" = "56" ]
then
	# If @ "Work" set location
	location="Work"
else
	# If not @ work the just set the location
	location="Home"
fi

# Update the location
newloc=`/usr/sbin/scselect "${location}" | sed 's/^.*(\(.*\)).*$/\1/'`

echo ${newloc}

if [ "${location}" != "${newloc}" ]
then
    exit 1
fi
exit 0
