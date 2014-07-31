#!/bin/bash -e

test -d $1/../__global && rsync -aq --delete $1/../__global/* $2:/etc/nagios/
rsync -aq --delete $1/* $2:/etc/nagios/

exit 0
