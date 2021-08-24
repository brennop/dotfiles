# disable message
set fish_greeting 

# aliases
alias query 'xbps-query -Rs'
alias add 'sudo xbps-install'
alias remove 'sudo xbps-remove'

# functions
function enable
    sudo ln -s "/etc/sv/$argv" /var/service/
end

# abbr
abbr -a -g att 'tmux a -t'

# env
set -x EDITOR vim
set -x VISUAL vim

# asdf
source ~/.asdf/asdf.fish
