#!/bin/bash

install_with_notifications () {
  password=$(rofi -dmenu -password -p "password")
  notify-send "Installing $@"
  message=$(echo $password | sudo -S xbps-install -y $@ 2>&1 > /dev/null)
  if [ $? -eq 0 ]
  then
    notify-send "Installation completed" $@
  else
    notify-send "Installation failed" $message -u critical
  fi
}

export -f install_with_notifications

programs=$(fish -c __fish_print_xbps_packages | cut -f 1 | rofi -dmenu -i -multi-select -matching fuzzy -p "install")

if [[ -n "$programs" ]]
then
  install_with_notifications $programs
fi
