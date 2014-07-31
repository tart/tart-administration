#!/bin/bash -e
 ##
 # Tart System Administration
 # Server Configuration Deployment
 #
 # @args    Directories to be deployed
 ##

 ##
 # Script should be executed on the root of the repository.  SSH keys should be added to the servers.
 ##

directory=${0%/*}

test -n "$1" || (echo "No arguments." >&2; exit 2)

for target in $@; do

    # Continue if it is an optional argument.
    if echo $target | grep -q ^-; then
        continue
    fi

    # Continue if it is a protected directory.
    if echo $target | grep -q /_; then
        continue
    fi

    service=${target%/*}
    host=${target#*/}

    # Continue if deployment script for the configuration target does not exists.
    if test ! -x $directory/configuration/$service.sh; then
        continue
    fi

    # Continue if the target does not modified and does not given as argument.
    if echo $@ | grep -q "\--check-git-revision" &&
            test -s .revision/$target &&
            git diff --quiet $(cat .revision/$target) $target &&
            (test ! -e $service/__global ||
                    git diff --quiet $(cat .revision/$target) $service/__global); then
        continue
    fi

    for subhost in $($directory/recursiveHosts.py $host); do
        echo "Deploying $service configuration of $host to $subhost..."
        $directory/configuration/$service.sh $target $subhost
        $directory/service.sh $subhost $service reload
    done

    mkdir -p .revision/$service
    git rev-parse HEAD > .revision/$target
done

echo
exit 0
