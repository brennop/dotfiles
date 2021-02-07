#!/bin/sh

pgrep -x redshift > /dev/null || redshift &
picom &
feh --bg-fill $(cat ~/.cache/wal/wal) &
xsetroot -cursor_name left_ptr
setxkbmap -option ctrl:nocaps
wal -R &
