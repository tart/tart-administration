#!/bin/bash -e

zoneFileExist=
serialNumberUpToDate=

for zone in $1/*.zone; do
    test -f $zone && zoneFileExist=t
    grep -q $(date +%Y%m%d) $zone && serialNumberUpToDate=t
done

if test $zoneFileExist && test ! $serialNumberUpToDate; then
    echo "Serial number of a zone should be up-to-date." >&2
    exit 1
fi

scp -q $1/* $2:/etc/nsd

exit 0
