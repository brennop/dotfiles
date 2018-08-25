#!/bin/sh

bat="$(cat /sys/class/power_supply/BAT0/capacity)"
echo -e "\uf004 $bat"
