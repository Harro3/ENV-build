#!/bin/sh

set -e

script_dir=$(readlink -f $(dirname $0))
steps_dir=$script_dir/../steps

mkdir -p $steps_dir

help() {
    echo "Usage: $0 STEP_NAME [index]"
}

if [ $# -eq 0 ] || [ $# -gt 2 ]; then 
    help
    exit 1
fi

max_index=-1
for f in $(ls $steps_dir); do
    i=$(echo $f | cut -d '_' -f1)
    if [ $i -gt $max_index ]; then
        max_index=$i
    fi
done

if [ $# -eq 2 ]; then
    case $2 in
        ''|*[!0-9]*)
       echo Index $2 is not an integer
       help
       exit 1
       ;;
    esac

    index=$2

    curr=$index

    for f in $(ls $steps_dir); do
        i=$(echo $f | cut -d '_' -f1)        
        name=$(echo $f | cut -d '_' -f 2-)
        if [ $i -eq $curr ]; then
            echo $curr
            mv "$steps_dir/${i}_${name}" "$steps_dir/$((i+1))_${name}"
            curr=$(($curr+1))
        fi
    done

else
    index=$(($max_index + 1))
fi

if [ $index -gt $(($max_index+1)) ]; then
    index=$(($max_index + 1))
fi

step_dir=$steps_dir/${index}_$1

mkdir $step_dir

echo "#!/bin/sh

set -e
script_dir=\$(readlink -f \$(dirname \$0))
source \$script_dir/config.env

echo \"Your commands here\"" > $step_dir/gen_commands.sh
chmod +x $step_dir/gen_commands.sh
touch $step_dir/config.env
mkdir $step_dir/assets
touch $step_dir/summary.txt