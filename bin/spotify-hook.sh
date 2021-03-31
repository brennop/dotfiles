#!/bin/bash

if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ];
then
  trackName=$(playerctl metadata title)
  artistAndAlbumName=$(playerctl metadata --format "{{ artist }} ({{ album }})")

  notify-send -u low "$trackName" "$artistAndAlbumName "
fi

if [ "$PLAYER_EVENT" = "change" ];
then
  wget $(playerctl metadata mpris:artUrl) -O ~/.cache/art.png
fi
