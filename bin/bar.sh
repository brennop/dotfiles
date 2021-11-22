#!/bin/bash

date=$(date +'%l:%M %p')
bat=$(cat /sys/class/power_supply/BAT0/capacity)

echo "$date - $bat%"
