FROM debian:jessie

# Don't start ion install
run     echo "#!/bin/sh\nexit 101" >/usr/sbin/policy-rc.d && \
        chmod +x /usr/sbin/policy-rc.d

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor rsyslog \
	prosody lua-cyrussasl lua-zlib lua-event libsasl2-modules-ldap && \
	dpkg-divert --local --rename --add /sbin/initctl && \
	apt-get clean  && \
        rm -rf /var/lib/apt/lists/*

ADD	root /

RUN	chmod +x /prosody-start

# Default configuration: can be overridden at the docker command line
env	LDAP_URL ldap://ldap.o-g.at
env	LDAP_BASE ""

expose 5269,5222

CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

# To store the data outside the container,..

