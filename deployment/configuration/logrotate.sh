#!/bin/bash -e

test -d $1/../__global && scp -q $1/../__global/logrotate.conf $2:/etc
scp -q $1/* $2:/etc/logrotate.d/

# logrotate executed by cron deamon.  Reload does not required.
exit 0
