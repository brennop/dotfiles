#!/bin/bash

# Video Quality
# The range of the CRF scale is 0–51, where 0 is lossless, 23 is the default,
# and 51 is worst quality possible. A lower value generally leads to higher
# quality, and a subjectively sane range is 17–28
QUALITY=28

# check if slop command exists
if ! command -v slop &> /dev/null
then
    echo "slop command not found. Please install slop."
    exit 1
fi

# set the output file name
filename="$(readlink -f ~/Videos/Screencasts/)/$(date).mp4"

# get the selection coordinates using slop
echo "Select the desktop area to record."
coords=$(slop -f "%x %y %w %h")

# extract the x, y, width, and height values from the coordinates
x=$(echo $coords | awk '{print $1}')
y=$(echo $coords | awk '{print $2}')
width=$(echo $coords | awk '{print $3}')
height=$(echo $coords | awk '{print $4}')

# ensure that the height and width are divisible by 2
width=$((width / 2 * 2))
height=$((height / 2 * 2))

# display message to user
echo "Recording started. Press 'q' to stop recording."

# run the ffmpeg command
ffmpeg -f x11grab -s ${width}x${height} -i ${DISPLAY}+$x,$y \
    -f alsa -i pulse -c:v libx264 -preset ultrafast -crf ${QUALITY} \
    -tune zerolatency -pix_fmt yuv420p -an -f mp4 "$filename"

# display message to user
echo "Recording stopped."
