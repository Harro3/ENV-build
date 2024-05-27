#!/bin/sh

set -e
script_dir=$(readlink -f $(dirname $0))
source $script_dir/config.env

for package in $PACKAGES; do
    echo "$COMMAND $package"
done