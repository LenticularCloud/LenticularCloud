FROM debian:jessie

# Don't start slapd on install
run     echo "#!/bin/sh\nexit 101" >/usr/sbin/policy-rc.d && \
        chmod +x /usr/sbin/policy-rc.d

add root/etc/packager.io.apt.key /etc/packager.io.apt.key

# Configure apt
run	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https && \
	apt-get upgrade -y
run	apt-key add /etc/packager.io.apt.key && \
	echo "deb https://deb.packager.io/gh/pkgr/gogs wheezy pkgr" > /etc/apt/sources.list.d/gogs.list && \
	apt-get -y update && \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y sendmail logrotate supervisor rsyslog gogs git openssh-server && \
	dpkg-divert --local --rename --add /sbin/initctl && \
	apt-get clean  && \
	rm -rf /var/lib/apt/lists/* /etc/ssh/ssh_host*

#copy the configs
ADD root/ /

RUN	chmod +x /usr/bin/gogs-start


# Default configuration: can be overridden at the docker command line

expose 3000 22

CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
