# Directory Structure

First level of directories are for application.  There should be a deployment script under
[deployment/configuration](deployment/configuration) for all applications in here, if they will be deployed
somewhere.  These directories are also implicitly define host groups.  For example;

    nginx/
        production/
            default.conf
        backup/
            default.conf

will define a host group named `nginx` by the hosts `production` and `backup`.

Second level of directories are for host or host groups.  They will first be tried as host groups.  If there is
an upper level directory with the same name, it will be considered as a host group.  If not, it will be a host.
See [deployment/recursiveHosts.py](deployment/recursiveHosts.py) for the algorithm.  More than one directory
configurations can be deployed to hosts, if they are in host groups.  For example;

    logroate
        nginx/
            nginx.conf
        production/
            customLogs.conf

will deploy both of the configurations `nginx.conf` and `customLogs.conf` to the host `production`.

Name of the second level directories will be used to deploy configurations to the hosts.  The names will be
resolved by the DNS.  Using DNS search path is a convenient way to keep host names short.

To only define a host group without separate configurations, files can be created instead of directories under
the first level of directories.  For example;

    debian/
        production
        backup
        test
    rsyslog/
        debian/
            local.conf

will define host group `debian` without any configuration and allow the host group to be used to for other
configurations.

Directories which names start with `__` are reserved for special use.  `__global` is the one for the configurations
which will be deployed to the all servers.  Their usage dependents on the deployment script.  See the scrips
under [deployment/configuration](deployment/configuration) for their details. 
