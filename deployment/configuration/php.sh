#!/bin/bash -e

ssh $2 mkdir -p /etc/php/conf.d

test -d $1/../__global && scp -q $1/../__global/* $2:/etc/php/
scp -q $1/* $2:/etc/php/conf.d/

exit 0
