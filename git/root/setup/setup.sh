#!/bin/bash

LDIF_DIR="$DATA_ROOT/ldap/setup"


slapadd -l $LDIF_DIR/user.ldif
