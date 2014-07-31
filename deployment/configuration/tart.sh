#!/bin/bash -e

chmod -R g+w $1/*
scp -rpq $1/* $2:/etc/tart

exit 0
