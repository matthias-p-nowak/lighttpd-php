FROM alpine:latest

COPY input/*.sh /bin
RUN chmod +x /bin/*.sh && /bin/install.sh
COPY input/lighttpd /etc/lighttpd
COPY input/php83 /etc/php83
RUN chown lighttpd /var/log/php83

EXPOSE 80

VOLUME [ "/output", "/live" ]
ENTRYPOINT [ "/bin/run.sh" ]