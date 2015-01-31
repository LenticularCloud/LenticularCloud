#!/bin/bash

BASE=$(echo "dc=${LDAP_DOMAIN}" | sed "s/\./,dc=/")
URI=$LDAP_URI
PASSWORD=$LDAP_ROOTPASS


#replace placeholder in config
sed -i s/__BASE__/${BASE}/g          /etc/ldap/ldap.conf
sed -i s/__URI__/${URI}/g            /etc/ldap/ldap.conf
sed -i s/__URI__/${URI}/g            /etc/ldap/slapd.conf
sed -i s/__BASE__/${BASE}/g          /etc/ldap/slapd.conf
sed -i s/__URI__/${BASE}/g           /etc/ldap/slapd.conf
sed -i s/__PASSWORD__/${PASSWORD}/g  /etc/ldap/slapd.conf

sed -i s/__BASE__/${BASE}/g     "/setup/ou=user.ldif"


slapadd -l "setup/ou=user.ldif"
