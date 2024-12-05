#!/bin/sh
mkdir -pv /output/lighttpd
# aiosmtpd -n -l :25 -d -u  >/output/mail 2>&1   &
echo "running lighttpd"
exec  /usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf 