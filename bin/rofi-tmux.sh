#!/usr/bin/bash

sessions=$(tmux ls -F "#S")
session=$(echo "$sessions" | rofi -dmenu -p "tmux")

if [[ -z "$session" ]]
then
  exit 0
else
  rofi-sensible-terminal -e tmux new -As $session &
fi
