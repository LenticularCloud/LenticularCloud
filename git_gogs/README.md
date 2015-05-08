Git GOGS service
================


Installation
------------

edit git_gogs/settings.conf

run:

  cloud.sh build git_gogs
  cloud.sh run git_gogs

configure webserver to proxy to `localhost:xxxx` (use the port from the config.)

open bowser `https://git.example.org/`

settings:

  mysql_user: root
  mysql_password: 123456

  user: gogs


ldp auth:

open `https://git.example.org/admin/auths`

`Add New Authorization Source`

Settings:

Authorization Type: ldap
Authorization Name: ldap
Domain: example.com
Host: ldap.example.com
Port: 389
Base DN: OU=users,DC=git_gogs,DC=example,DC=org
Username attribute: uid
First name attribute:
Surname attribute:
E-mail attribute: mail
Search Filter: (&amp;(objectClass=inetOrgPerson)(uid=%s))
Ms Ad SA: uid=%s,OU=users,DC=git_gogs,DC=example,DC=org
Enable Auto Registration: yes
