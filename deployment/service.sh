#!/bin/bash -e
 ##
 # Tart Server Administration
 # Application Deployment
 #
 # @arg1    Server
 # @arg2    Service
 # @arg3    Action
 ##

 ##
 # SSH keys should be added to the authorized keys on the servers.
 ##

if [ ! "$3" ]; then
    echo "Missing arguments" >&2
    exit 1
fi

if ssh $1 test -x /etc/init.d/$2; then
    ssh $1 sudo /etc/init.d/$2 $3
fi

if ssh $1 test -x /etc/rc.d/$2; then
    ssh $1 sudo /etc/rc.d/$2 $3
fi

if ssh $1 test -x /usr/local/etc/rc.d/$2; then
    ssh $1 sudo /usr/local/etc/rc.d/$2 $3
fi

exit 0
