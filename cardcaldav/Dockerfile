FROM debian:jessie

# Don't start slapd on install
run     echo "#!/bin/sh\nexit 101" >/usr/sbin/policy-rc.d && \
        chmod +x /usr/sbin/policy-rc.d

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y python- logrotate supervisor \
	python-pip python-ldap &&\
	dpkg-divert --local --rename --add /sbin/initctl && \
	apt-get clean  && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /etc/ldap/slapd.d

#copy the configs
ADD conf /
#ADD ssl /etc/ldap/ssl

RUN pip install radicale && \
    chmod +x /usr/bin/radicale-start && \
#    chown openldap:openldap -R /etc/ldap && \
#    chmod ugo+x -R /etc/ldap


# Default configuration: can be overridden at the docker command line
#env	LDAP_ROOTPASS verySecure
#env	LDAP_ORGANISATION Example-Company
#env	LDAP_DOMAIN example.com

expose 8001

#cmd	["/usr/bin/slapd-start"]
CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

# To store the data outside the container, mount /var/lib/ldap as a data volume

# vim:ts=8:noet:
