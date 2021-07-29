#!/bin/bash

if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ];
then
  meta=$(playerctl -p spotifyd metadata)

  title=$(echo "$meta" | awk '$2=="xesam:title"{print $3}')
  artist=$(echo "$meta" | awk '$2=="xesam:artist"{print $3}' | sed -z 's/\n/, /g;s/, $/\n/' )
  album=$(echo "$meta" | awk '$2=="xesam:album"{print $3}')
  artUrl=$(echo "$meta" | awk '$2=="mpris:artUrl"{print $3}')

  if [ "$artUrl" != "$(cat ~/.cache/artUrl)" ]; then
    wget "$artUrl" -O ~/.cache/art.png
    echo "$artUrl" > ~/.cache/artUrl
  fi

  notify-send -u low "$title" "$artist ($album)" -i "~/.cache/art.png"
fi
