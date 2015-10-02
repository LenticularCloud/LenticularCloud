FROM debian:jessie

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y sendmail logrotate supervisor rsyslog apt-transport-https wget && \
  echo "deb https://apt.jabber.at jessie ejabberd"  > /etc/apt/sources.list.d/jabber.at.list  && \
  wget -qO- https://apt.jabber.at/gpg-key | apt-key add - && \
  LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y ejabberd && \
	apt-get clean  && \
	rm -rf /var/lib/apt/lists/*

#copy the configs
ADD root/ /

RUN	chmod +x /usr/bin/radicale-start


# Default configuration: can be overridden at the docker command line

expose 8080

CMD /usr/bin/radicale-start
