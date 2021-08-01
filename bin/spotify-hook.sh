#!/bin/bash

if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ];
then
  meta=$(playerctl -p spotifyd metadata)

  title=$(echo "$meta" | awk '$2=="xesam:title"' | tr -s ' ' | cut -f 3- -d ' ')
  artist=$(echo "$meta" | awk '$2=="xesam:artist"' | tr -s ' ' | cut -f 3- -d ' ' | sed -z 's/\n/, /g;s/, $/\n/' )
  album=$(echo "$meta" | awk '$2=="xesam:album"' | tr -s ' ' | cut -f 3- -d ' ')
  artUrl=$(echo "$meta" | awk '$2=="mpris:artUrl"' | tr -s ' ' | cut -f 3- -d ' ')

  if [ "$artUrl" != "$(cat ~/.cache/artUrl)" ]; then
    wget "$artUrl" -O ~/.cache/art.png
    echo "$artUrl" > ~/.cache/artUrl
  fi

  notify-send -u low "$title" "$artist ($album)" -i "~/.cache/art.png"
fi
