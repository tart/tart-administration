#!/usr/bin/env python
# -*- coding: utf-8 -*-
##
# Tart Integration
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
##

import os
import socket
from recursiveHosts import recursiveHosts

class NagiosObject(object):
    """Abstract class for Nagios object definitions. Properties should be defined by child classes."""

    def printSection(self):
        print('define ' + self.header + ' {')

        for key, value in self.__dict__.items():
            if value:
                print('    ' + key.ljust(24) + self.formatValue(value))

        print('}')
        print('')

    def formatValue(self, value):
        if isinstance(value, list):
            return ','.join(value)
        return str(value)

class NagiosHost(NagiosObject):
    header = 'host'

    def __init__(self, name):
        self.host_name = name
        self.use = 'default'
        self.hostgroups = []

        try:
            self.address = socket.gethostbyname(name)   # Query host address from DNS
        except socket.gaierror:
            raise Exception('DNS resolution failed for ' + name)

hostgroups = (
    'openbsd',
    'freebsd',
    'linux',
    'macosx',
    'windows',
    'mongodb',
    'crontab',
    'httpd',
    'nginx',
    'openldap',
    'rabbitmq',
    'pgbouncer',
    'php-fpm',
    'postgresql',
    'redis',
    'rsyslog',
    'solr',
    'supervisor',
    'tomcat',
    'isteoyun',
    'postfix',
    'mysql',
    'nagios',
    'esx',
)

def main():
    hosts = {}

    for hostgroup in hostgroups:
        if os.path.isdir(hostgroup):
            for name in recursiveHosts(hostgroup):
                if name not in hosts:
                    hosts[name] = NagiosHost(name)

                hosts[name].hostgroups.append(hostgroup)

    for host in hosts.values():
        host.printSection()

if __name__ == '__main__':
    main()
