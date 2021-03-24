#!/bin/bash

pgrep -x redshift > /dev/null || redshift &
picom &
xsetroot -cursor_name left_ptr
setxkbmap us,br -option ctrl:nocaps,grp:alt_shift_toggle
wal -R &
