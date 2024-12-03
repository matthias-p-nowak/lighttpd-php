FROM alpine:latest

COPY input/install.sh /tmp
RUN chmod +x /tmp/install.sh && /tmp/install.sh
COPY input/lighttpd /etc/lighttpd
COPY input/php83 /etc/php83
RUN chown lighttpd /var/log/php83

EXPOSE 80

VOLUME [ "/output", "/live" ]
ENTRYPOINT [ "/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]