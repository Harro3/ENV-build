#!/bin/sh

set -e
set -a

# Go to this directory
cd $(dirname $(readlink -f "$0"))

start_step() {
    step_name=$1
    desc=$2

    source ./envs/$step_name.env

    echo "Next step is \"$step_name\""
    echo "> $desc"

    read -p "Skip ? [y|N]: " skip

    case "$skip" in
        [yY]|[yY][eE][sS])
            return;;
    esac

    echo "=== STEP \"$step_name\" ==="
    exec ./steps/$step_name.sh
}


# Executing steps
# exec {steps_file}<steps_list.txt
# while read -u$steps_file -r line || [[ -n "$line" ]]; do
#     IFS=':' read -r step desc <<< "$line"
#     start_step "$step" "$(sed 's/^[[:space:]]*//' <<< $desc)"
# done < 

while read p <&3 || [[ -n $p ]]; do
    IFS=':' read -r step desc <<< "$p"
    desc="$(sed 's/^[[:space:]]*//' <<< "$desc")"
    start_step "$step" "$desc"

done 3< steps_list.txt