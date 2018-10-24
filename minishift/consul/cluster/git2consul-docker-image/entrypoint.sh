#!/bin/sh
set -x

# init
node=$(which node)

# For some this can't locate the git2consul binary and hence change of directory
cd /usr/lib/node_modules

# DEBUG
# cat /etc/git2consul.d/config.json

$node git2consul --config-file /etc/git2consul.d/config.json "$@"

