#!/bin/sh

bat="$(cat /sys/class/power_supply/BAT0/capacity)"
echo -e "$bat \ue107"
