#!/usr/bin/bash

# get emojis
url=https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json
db=~/.cache/emojis.json
emojis=$(cat $db || (curl -L $url > $db && cat $db))

list=$(echo $emojis | jq '.[] | .emoji + " ", .description + " ", if (.tags | length > 0) then "(" + (.tags | join(",")) + ")" else "" end,"\n"' -j )
selection=$(echo "$list" | rofi -dmenu -matching fuzzy -sort -sorting-method fzf -p emoji)
emoji=$(echo $selection | awk '{ print $1 }')

# try to type, or copy otherwise
xdotool type $emoji || (echo -n $emoji | xclip -sel clip)

