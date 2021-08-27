#!/usr/bin/bash

file=$(rg ~ --files --hidden --no-messages | rofi -dmenu -i)
filetype=$(xdg-mime query filetype "$file")
application=$(xdg-mime query default "$filetype")
use_terminal=$(cat /usr/share/applications/"$application" | grep "Terminal=true")

if [ -n "$use_terminal" ]
then
  rofi-sensible-terminal -e "xdg-open" "$file"
else
  xdg-open "$file"
fi
