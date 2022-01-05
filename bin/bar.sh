#!/bin/bash

clock() {
  time=$(date +'%l:%M %p')
  echo "$time"
}

battery() {
  bat=$(cat /sys/class/power_supply/BAT0/capacity)
  echo "$bat%"
}

while true; do
  echo "%{c}$(clock)"
  sleep 1
done
