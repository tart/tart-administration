#!/bin/bash -e

test -d $1/../__global && scp -q $1/../__global/* $2:/etc/redis/
scp -q $1/* $2:/etc/redis/

# Configuration test
ssh $2 redis-server /etc/redis/redis.conf

exit 0
