#!/bin/bash

picom &
dunst &
xsetroot -cursor_name left_ptr
setxkbmap us,br -option ctrl:nocaps,grp:alt_shift_toggle
~/.screenlayout/mirror.sh
hsetroot -solid \#d8d8d8
polybar main
