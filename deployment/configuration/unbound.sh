#!/bin/bash -e

scp -q $1/* $2:/etc/unbound/

exit 0
