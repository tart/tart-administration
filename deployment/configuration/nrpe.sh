#!/bin/bash -e

scp -q $1/* $2:/etc/nagios/

# NRPE reloads automatically.
exit 0
