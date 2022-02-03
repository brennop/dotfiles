#=============#
#   plugins   #
#=============#

if not functions -q fisher
  eval (curl -sL https://git.io/fisher | source)
  echo "run 'fisher update'"
end

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
abbr pull "git pull"
abbr push "git push -u origin HEAD"

abbr recommit "git commit --amend --no-edit --no-verify"


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

#===============#
#   functions   #
#===============#

function enable
  sudo ln -s "/etc/sv/$argv" /var/service/
end

complete -c enable -x -a "(ls /etc/sv)"

function save
  git add . && git commit -m (date -I) && git push
end

function todo
  git commit --allow-empty -m "TODO: $argv"
end

function proj
  cd ~/projects/"$argv" && tmux new -As "$argv"
end

complete -c proj -x -a "(ls ~/projects)"

#=========#
#   env   #
#=========#

set -x EDITOR nvim
set -x VISUAL vim

# disable message
set fish_greeting 

# fzf
# set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --no-messages --glob "!.git/"'

# rbenv
# status --is-interactive; and rbenv init - fish | source

# luarocks
# eval (luarocks path)
