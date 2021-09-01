#!/usr/bin/bash

# get emojis
emojis_url=https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json
emojis_db=~/.cache/emojis.json
emojis=$(cat $emojis_db || (curl -L $emojis_url > $emojis_db && cat $emojis_db))

emoji_list=$(echo $emojis | jq '.[] | .emoji, " ", .description, " (", (.tags | join(", ")), ")\n"' -j)
emoji=$(echo "$emoji_list" | rofi -dmenu -matching fuzzy -sort -sorting-method fzf -p emoji | awk '{ print $1 }')

echo -n $emoji | xclip -sel clip

