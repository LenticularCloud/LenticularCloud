FROM debian:jessie

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y sendmail logrotate supervisor rsyslog radicale python-ldap && \
	apt-get clean  && \
	rm -rf /var/lib/apt/lists/*

#copy the configs
ADD root/ /

RUN	chmod +x /usr/bin/radicale-start


# Default configuration: can be overridden at the docker command line

expose 8080

CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
