#!/bin/bash

# Apache and Shibd gets grumpy about PID files pre-existing from previous runs
rm -f /etc/httpd/run/httpd.pid /var/lock/subsys/shibd

# Make sure /etc/shibboleth/shibd-redhat is executable
chmod +x /etc/shibboleth/shibd-redhat

# Start Shibd
/etc/shibboleth/shibd-redhat start

yes | cp /etc/hosts /etc/hosts2 && sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\tlocalhost $SERVER_NAME/" /etc/hosts2 && yes | cp /etc/hosts2 /etc/hosts

# Start httpd
exec httpd -DFOREGROUND
