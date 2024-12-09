#!/bin/sh

apk add lighttpd php83-pecl-xdebug php83-fpm php83-session php83-dom php83-mbstring php83-zip \
 py3-aiosmtpd netcat-openbsd
echo 'all done'
sleep 2
