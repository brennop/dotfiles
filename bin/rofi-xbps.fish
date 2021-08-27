#!/usr/bin/fish

rofi-sensible-terminal -e sudo xbps-install -S (__fish_print_xbps_packages | cut -f 1 | rofi -dmenu -i -p "install") &
