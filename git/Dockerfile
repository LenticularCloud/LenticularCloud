FROM debian:jessie

# Don't start slapd on install
run     echo "#!/bin/sh\nexit 101" >/usr/sbin/policy-rc.d && \
        chmod +x /usr/sbin/policy-rc.d

# Configure apt
run	apt-get -y update ; \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y logrotate supervisor \
	openssh-server sendmail wget \
	git-core ; \
	wget https://downloads-packages.s3.amazonaws.com/debian-7.6/gitlab_7.7.1-omnibus.5.4.1.ci-1_amd64.deb -O /tmp/gitlab_amd64.deb ; \
	dpkg -i /tmp/gitlab_amd64.deb ; \
	LC_ALL=C DEBIAN_FRONTEND=noninteractive  apt-get install -f ; \
	rm /tmp/gitlab_amd64.deb ;\
	dpkg-divert --local --rename --add /sbin/initctl ; \
	apt-get clean  ; \
	rm -rf /var/lib/apt/lists/*

#copy the configs
ADD root /

RUN /opt/gitlab/embedded/bin/runsvdir-start &  \
    sleep 10 ;\
    chmod +x /setup/setup.sh ;\
    gitlab-ctl reconfigure ;\
    rm /var/opt/gitlab -r 


# Default configuration: can be overridden at the docker command line
env	LDAP_BASE "dc=example,dc=com"
env	LDAP_GIT_USER "cn=git,dc=example,dc=com"
env	LDAP_GIT_PASSWORD "verySecure"



VOLUME /var/opt/gitlab

expose 22
expose 80

CMD     ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
#    initctl start gitlab-runsvdir && \
