#!/bin/bash -e
 ##
 # Tart Server Administration
 # Application Deployment
 #
 # @arg1    Application server
 # @arg2    Source path (optional)
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

chmod -R g+w ./$2

echo "Deploying to $1..."
ssh $1 "test ! -L $path/current || rsync -qa $path/current/ $path/$build"
rsync -qa --delete --exclude=.git* ./$2 $1:$path/$build
echo

${0%/*}/updateLink.sh $1

exit 0
