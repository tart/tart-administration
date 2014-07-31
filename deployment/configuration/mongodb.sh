#!/bin/bash -e

scp -q $1/* $2:/etc/mongodb/

exit 0
