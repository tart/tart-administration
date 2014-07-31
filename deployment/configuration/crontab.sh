#!/bin/bash -e

cat $1 | ssh $2 crontab -

exit 0
