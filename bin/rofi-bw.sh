#!/usr/bin/bash

password=$(rofi -dmenu -password -p "password")
token=$(bw unlock $password | grep -oP -m1 'BW_SESSION="(.*?)"' | cut -d '"' -f2) 

if [[ -z "$token" ]]
then
  notify-send "Invalid password" -u critical
fi

items=$(bw list items --session $token)
name=$(echo "$items" | jq '.[].name' -r | rofi -dmenu -i)

item=$(echo "$items" | jq --arg name $name 'map(select(.name | match($name)))')

echo "$item" | jq '.[0].notes // .[0].login.password' -r | xclip -sel clip

