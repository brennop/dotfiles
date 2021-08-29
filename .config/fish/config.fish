# disable message
set fish_greeting 

#=============#
#   aliases   #
#=============#

# xbps
alias query   "xbps-query -Rs"
alias add     "sudo xbps-install"
alias update  "sudo xbps-install -S"
alias remove  "sudo xbps-remove"

# git
abbr gti  "git"
abbr ga   "git add"
abbr gaa  "git add --all ."
abbr gsw  "git switch"

alias push  "git push -u origin HEAD"

# docker
abbr dcb "docker-compose build"
abbr dcu "docker-compose up"
abbr dcr "docker-compose run --rm"
abbr dps "docker ps"
abbr up   "dcu"

# tmux
alias mux tmuxinator
abbr -g att  "tmux a -t"
abbr -g t "tmux new -As"

# misc
abbr :q "exit"
abbr chmox "chmod +x"

#=========#
#   env   #
#=========#

set -x EDITOR vim
set -x VISUAL vim

# rbenv
status --is-interactive; and rbenv init - fish | source
