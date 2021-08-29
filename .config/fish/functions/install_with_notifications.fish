function install_with_notifications
  set message (sudo xbps-install $argv 2>&1 > /dev/null)
  if test $status -eq 0
    notify-send "Installed $argv"
  else
    notify-send "Instalation failed" $message -u critical
  end
end
