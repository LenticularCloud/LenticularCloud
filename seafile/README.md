RADICALE service
================


service that provides carddav and caldav.


Installation
------------

edit radicale/settings.conf

run:

  cloud.sh build radicale
  cloud.sh run radicale

configure webserver to proxy to `localhost:xxxx` (use the port from the config.)



configure some custom access rules in $DATA/radicale/rights/config

[Radicale Doc](http://radicale.org/user_documentation/#idlightning "Radicale - CalDAV and CardDAV Server - Contents")

