#!/bin/bash -e

test -d $1/../__global && scp -rpq $1/../__global/* $2:/etc/openldap
scp -q $1/* $2:/etc/openldap

exit 0
