FROM debian:jessie

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y sendmail logrotate supervisor rsyslog  wget && \
  echo "deb http://apt.jabber.at jessie ejabberd"  > /etc/apt/sources.list.d/jabber.at.list  && \
  wget -qO- https://apt.jabber.at/gpg-key | apt-key add - && \
  apt-get update && \
  LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y ejabberd && \
	apt-get clean  && \
	rm -rf /var/lib/apt/lists/*

#copy the configs
ADD root/ /

RUN	chmod +x /usr/bin/ejabberd-start && \
    chown ejabberd:ejabberd /etc/ejabberd /etc/default/ejabberd -R

# Default configuration: can be overridden at the docker command line

expose 5222 5269 5280

CMD /usr/bin/ejabberd-start
