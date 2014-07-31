#!/bin/bash -e

function copy {
    ssh $2 test -d $3 || return 0
    ssh $2 chgrp $4 $3/*
    ssh $2 chmod o-r $3/*
}

copy $1 $2 /etc/nginx/ssl nginx
copy $1 $2 /etc/postgresql/ssl postgres

exit 0
