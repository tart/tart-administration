#!/bin/bash -e

ssh $2 mkdir -p /etc/nginx/{conf.d,ssl}

test -d $1/../__global && scp -q $1/../__global/* $2:/etc/nginx
scp -q $1/* $2:/etc/nginx/conf.d

exit 0
