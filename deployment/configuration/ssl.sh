#!/bin/bash -e

function copy {
    ssh $2 test -d $3 || return 0
    test -d $1/../__global && scp -q $1/../__global/* $2:$3
    test -f $1/.gitkeep || scp -q $1/* $2:$3
    ssh $2 chgrp $4 $3/*
    ssh $2 chmod o-r $3/*
}

copy $1 $2 /etc/nginx/ssl nginx
copy $1 $2 /etc/postgresql/ssl postgres

exit 0
