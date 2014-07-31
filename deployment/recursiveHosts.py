#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Tart Deployment
#
# Copyright (c) 2013, Tart İnternet Teknolojileri Ticaret AŞ
#
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby
# granted, provided that the above copyright notice and this permission notice appear in all copies.
#
# The software is provided "as is" and the author disclaims all warranties with regard to the software including all
# implied warranties of merchantability and fitness. In no event shall the author be liable for any special, direct,
# indirect, or consequential damages or any damages whatsoever resulting from loss of use, data or profits, whether
# in an action of contract, negligence or other tortious action, arising out of or in connection with the use or
# performance of this software.
#

import os
import sys

def main(*args):
    if len(sys.argv) != 2:
        raise Exception('missing argument')

    for host in recursiveHosts(sys.argv[1]):
        print(host)

def distinct(func):
    def wrapped(*args, **kwargs):
        values = []
        for value in func(*args, **kwargs):
            if value not in values:
                values.append(value)
                yield value
    return wrapped

@distinct
def recursiveHosts(host):
    if host.startswith('_'):
        pass # Is it a private directory.
    elif host.startswith('.'):
        pass # Is it a hidden file.
    elif os.path.isdir(host):
        for host in os.listdir(host):
            for host in recursiveHosts(host):
                yield host
    else:
        yield host

if __name__ == '__main__':
    main(sys.argv)
