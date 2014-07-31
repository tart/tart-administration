#!/bin/bash -e

test -d $1/../__global && scp -q $1/../__global/rsyslog.conf $2:/etc/
scp -q $1/* $2:/etc/rsyslog.d

exit 0
