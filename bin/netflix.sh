#!/bin/sh

#hdmi_active="$(cat /sys/class/drm/card0/*HDMI*/status |grep '^connected')"
hdmi_active="$(xrandr |grep ' connected' |grep 'HDMI')"
vga_active="$(xrandr |grep ' connected' |grep 'VGA')"

if [ ! -z "$hdmi_active" ]; then

# turn hdmi output on and set resolutions
xrandr --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output LVDS-1 --primary --mode 1366x768 --pos 1920x312 --rotate normal --off --output DP-1 --off --output VGA-1 --off

# set audio profile
pacmd set-card-profile alsa_card.pci-0000_00_1b.0 output:hdmi-stereo

else 

# set audio profile
pacmd set-card-profile alsa_card.pci-0000_00_1b.0 output:analog-stereo


if [ ! -z "$vga_active" ]; then

xrandr --output LVDS-1 --primary --mode 1366x768 --pos 1920x312 --rotate normal --output VGA-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off


else

# disables hdmi
xrandr --output HDMI-1 --off --output LVDS-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --off --output DP-1 --off --output VGA-1 --off


fi

fi

# fix wallpaper
walp="$(cat ~/.cache/wal/wal)"
feh --bg-fill $walp

