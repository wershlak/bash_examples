#!/bin/bash
# 
# Jeff Wolak
#
# example bash cgi script
# 
# Grabbing the latest entry in the yum.log and returning 
# the current time and the time of the latest entry as 
# an XML status object
#
# Obviously this isn't useful but a client had me build 
# some similar CGI scripts to pull useful data from an
# application.
#
#  A python nagios plugin grabbed the info from the 
#  monitoring server
#  HTTPS was the only transport method approved for use

# --------------------------------------------------
# Example of /var/log/yum.log
# Aug 24 08:00:27 Updated: pam-1.1.8-12.el7_1.1.x86_64
# --------------------------------------------------

YUM_ENTRY=$(tail -1 /etc/yum.log)

ENTRY_TIME="$(date -d "${YUM_ENTRY:0:15}" +%Y%m%d%H%M%S 2>/dev/null)"

# --------------------------------------------------
# SYSTEM_TIME - UTC - YYYYMMDDHHmmSS - 20150225024912
# --------------------------------------------------

SYSTEM_TIME="$(date +%Y%m%d%H%M%S)"

# --------------------------------------------------
# CGI header and XML
# --------------------------------------------------

echo Content-type: text/xml
echo ""

# Print XML file
/bin/cat << EOM
<?xml version="1.0" encoding="UTF-8"?>
<status>
<time>$SYSTEM_TIME</time>
<entry>$ENTRY_TIME</entry>
</status>
EOM

exit 0
