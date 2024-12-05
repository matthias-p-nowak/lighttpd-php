#!/bin/sh
aiosmtpd -n -l :25 -d -u &
echo "running lighttpd"
exec  /usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf 