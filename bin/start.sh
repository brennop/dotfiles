#!/bin/bash

picom &
xsetroot -cursor_name left_ptr
setxkbmap us,br -option ctrl:nocaps,grp:alt_shift_toggle
~/.screenlayout/mirror.sh
pulseaudio --daemonize=no --exit-idle-time=-1 &
hsetroot -solid \#c8c8c8
