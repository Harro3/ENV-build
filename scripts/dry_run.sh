#!/bin/sh

set -e

script_dir=$(readlink -f $(dirname $0))
steps_dir=$script_dir/../steps

for step in $(ls $steps_dir | sort); do
    i=$(echo $step | cut -d '_' -f1)
    name=$(echo $step | cut -d '_' -f 2-)

    echo === STEP ${i} - ${name} ===
    echo
    cat $steps_dir/$step/summary.txt
    echo
    echo
    echo "This step runs the following commands:"
    $steps_dir/$step/gen_commands.sh | while read line; do echo "  - $line"; done
    echo
    echo 
done