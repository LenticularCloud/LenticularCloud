FROM debian:jessie

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y sendmail supervisor rsyslog openssl \
  python2.7 python-setuptools python-imaging sqlite3 python-ldap && \
	apt-get clean  && \
	rm -rf /var/lib/apt/lists/*

#copy the configs
ADD https://bitbucket.org/haiwen/seafile/downloads/seafile-server_4.1.2_x86-64.tar.gz /seafile-server.tar.gz
run adduser -q --home /var/lib/seafile --disabled-password --disabled-login seafile && \
    tar xzf seafile-server.tar.gz -C /var/lib/seafile/ && \
    ln -s /var/lib/seafile/seafile-server-* /var/lib/seafile/seafile-server-latest
ADD root/ /

RUN	chmod +x /usr/bin/seafile-start


# Default configuration: can be overridden at the docker command line

expose 8080 10001 8082 12001

CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
