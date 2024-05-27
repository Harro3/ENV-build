#!/bin/sh

set -e

script_dir=$(readlink -f $(dirname $0))
steps_dir=$script_dir/../steps

help() {
    echo "Usage: $0 STEP_INDEX"
}

if [ $# -ne 1 ]; then
    help
    exit 1
fi

case $1 in
    ''|*[!0-9]*)
        echo Index $1 is not an integer
        help
        exit 1
        ;;
esac

index=$1
for f in $(ls $steps_dir); do
    i=$(echo $f | cut -d '_' -f1)
    name=$(echo $f | cut -d '_' -f 2-)
    if [ $i -eq $index ]; then
        rm -rf $steps_dir/$f
    fi
    if [ $i -gt $index ]; then
        mv "$steps_dir/${i}_${name}" "$steps_dir/$((i-1))_${name}"
    fi
done
