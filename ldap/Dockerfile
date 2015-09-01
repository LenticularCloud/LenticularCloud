FROM debian:jessie

# Don't start slapd on install
run     echo "#!/bin/sh\nexit 101" >/usr/sbin/policy-rc.d && \
        chmod +x /usr/sbin/policy-rc.d

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y python-software-properties logrotate supervisor rsyslog slapd && \
	dpkg-divert --local --rename --add /sbin/initctl && \
	apt-get clean  && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /etc/ldap/slapd.d

#copy the configs
ADD root/ /

RUN	chmod +x /usr/bin/slapd-start && \
    chown openldap:openldap -R /etc/ldap && \
    chmod ugo+x -R /etc/ldap 
#    chmod +x /setup/setup.sh


expose 389

cmd	["/usr/bin/slapd-start"]
#CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

# To store the data outside the container, mount /var/lib/ldap as a data volume

# vim:ts=8:noet:
