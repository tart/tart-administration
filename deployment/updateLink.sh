#!/bin/bash -e
 ##
 # Tart Server Administration
 # Application Deployment
 #
 # @arg1    Application server or server group
 # @env     JOB_NAME
 # @env     BUILD_ID
 ##

 ##
 # SSH keys should be added to the authorized keys on the servers.
 ##

if [ ! "$1" ]; then
    echo "Missing arguments" >&2
    exit 1
fi

if [ ! "$JOB_NAME" ]; then
    echo "Missing environment variable JOB_NAME" >&2
    exit 1
fi

if [ ! "$BUILD_ID" ]; then
    echo "Missing environment variable BUILD_ID" >&2
    exit 1
fi

path=/data/$JOB_NAME
build=$BUILD_ID

echo "Updating symbolic link on $1..."
ssh $1 ln -sfT $path/$build $path/current
echo

exit 0
