#!/bin/bash

picom &
xsetroot -cursor_name left_ptr
setxkbmap us,br -variant "altgr-intl," -option ctrl:nocaps,grp:alt_shift_toggle
~/.screenlayout/mirror.sh
hsetroot -solid \#c8c8c8
