#!/bin/bash

query=$(rofi -dmenu -p search)

if [ -z "$query" ]; then
    exit 0
fi

results=$(spotify-tui search --tracks --limit 10 "$query")

selection=$(echo "$results" | rofi -dmenu -i -matching fuzzy -sort -sorting-method fzf -p "search: $query")

# If the user didn't select anything, exit
if [ -z "$selection" ]; then
  exit 0
else
  # Get the track URI from the selection
  # The URI is the last column of the selection
  uri=$(echo "$selection" | awk '{print $NF}')
  # remove parenthesis
  uri=${uri:1:-1}
  # Play the track
  spotify-tui play --uri "$uri"
fi

