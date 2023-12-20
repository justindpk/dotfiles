#!/usr/bin/bash

# Nuke all internal spawns when script dies
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM

BARS=12;
FRAMERATE=60;
EQUILIZER=1;
WIDTH=1;

# Get script options
while getopts 'b:f:eh' flag; do
    case "${flag}" in
        b) BARS="${OPTARG}" ;;
        f) FRAMERATE="${OPTARG}" ;;
        e) EQUILIZER=0 ;;
        h)
            echo "caway usage: caway [ options ... ]"
            echo "where options include:"
            echo "  -b <integer>  (Number of bars to display. Default 8)"
            echo "  -f <integer>  (Framerate of the equilizer. Default 60)"
            echo "  -e            (Disable equilizer. Default enabled)"
            echo "  -h            (Show help message)"
            exit 0
            ;;
    esac
done

# Check if EQUILIZER is enabled
if [[ $EQUILIZER == 0 ]]; then
    exit 0
fi

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar + thin space " "
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1} /g;"
    i=$((i=i+1))
done

# Remove last extra thin space
dict="${dict}s/.$//;"

clean_create_pipe() {
    if [ -p $1 ]; then
        unlink $1
    fi
    mkfifo $1
}

# Clean pipe for cava
cava_waybar_pipe="/tmp/cava_waybar.fifo"
clean_create_pipe $cava_waybar_pipe

# Custom cava config
cava_waybar_config="/tmp/cava_waybar_config"
echo "
[general]
mode = normal
framerate = $FRAMERATE
bars = $BARS
bar_width = $WIDTH
sensitivity = 100

[output]
method = raw
raw_target = $cava_waybar_pipe
data_format = ascii
ascii_max_range = 7
channels = mono
mono_option = average
reverse = 0

[smoothing]
monstercat = 1
noise_reduction = 60
" > $cava_waybar_config

# cava output into cava_waybar_pipe
cava -p $cava_waybar_config >$cava_waybar_pipe &

# Read the cava o/p via its fifo pipe
while read -r cmd; do
    # Change ASCII numbers to bars
    echo $cmd | sed "$dict"
done < $cava_waybar_pipe
