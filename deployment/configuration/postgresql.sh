#!/bin/bash -e

ssh $2 mkdir -p /etc/postgresql/{conf.d,ssl}
test -d $1/../__global && scp -q $1/../__global/* $2:/etc/postgresql
test -f $1/.gitkeep || scp -q $1/* $2:/etc/postgresql/conf.d/

exit 0
