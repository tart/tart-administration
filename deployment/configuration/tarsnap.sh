#!/bin/bash -e

test -d $1/../__global && scp -q $1/../__global/* $2:/etc/tarsnap
scp -q $1/* $2:/etc/tarsnap

ssh $2 /usr/local/bin/tarsnap --fsck

exit 0
