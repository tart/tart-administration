#!/bin/bash -e

scp -rpq $1/* $2:/etc/isteoyun

exit 0
