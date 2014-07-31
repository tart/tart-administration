#!/bin/bash -e
 ##
 # Tart Server Administration
 # Application Deployment
 #
 # @arg1    Application server
 # @arg2    Supervisord program string (optional)
 # @env     JOB_NAME (required if arg2 does not given)
 ##

 ##
 # SSH keys should be added to the authorized keys on the servers.
 ##

if [ ! "$1" ]; then
    echo "Missing arguments" >&2
    exit 1
fi

if [ "$2" ]; then
    programs=$2
elif [ "$JOB_NAME" ]; then
    programs=$JOB_NAME:*
else
    echo "Missing argument or environment variable JOB_NAME" >&2
    exit 1
fi

echo "Restarting $programs Supervisord programs on $1..."
supervisorctl -s http://$1:9001 restart $programs
echo

exit 0

