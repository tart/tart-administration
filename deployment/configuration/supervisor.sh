#!/bin/bash -e

test -d $1/../__global && scp -q $1/../__global/supervisord.conf $2:/etc
scp -q $1/* $2:/etc/supervisor.d

supervisorctl -s http://$2:9001 update
exit 0
