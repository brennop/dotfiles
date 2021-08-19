#!/bin/bash

picom &
dunst &
xsetroot -cursor_name left_ptr
setxkbmap us,br -option ctrl:nocaps,grp:alt_shift_toggle
~/./.fehbg
~/.screenlayout/mirror.sh
pulseaudio --daemonize=no --exit-idle-time=-1 &
polybar main &
wal -R
