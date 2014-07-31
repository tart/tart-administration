#!/bin/bash -e

ssh $2 mkdir -p /etc/php-fpm/conf.d

test -d $1/../__global && scp -q $1/../__global/* $2:/etc/php-fpm/
scp -q $1/* $2:/etc/php-fpm/conf.d/

exit 0
