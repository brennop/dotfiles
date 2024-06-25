#=============#
#   aliases   #
#=============#

# xbps
alias query   "apt search"
alias add     "sudo apt install"
alias update  "sudo apt update"
alias remove  "sudo apt remove"

# git
abbr gti  "git"
abbr ga   "git add"
abbr gaa  "git add --all ."
abbr comm "git commit"
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

function proj
  cd ~/projects/"$argv" && tmux new -As "$argv"
end

complete -c proj -x -a "(ls ~/projects)"

#=========#
#   env   #
#=========#

set -x EDITOR nvim
set -x VISUAL nvim

# disable message
set fish_greeting 

# luarocks
# eval (luarocks path)

# cat ~/.cache/wal/sequences
status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source

# pnpm
set -gx PNPM_HOME "/home/brenno/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# https://evantravers.com/articles/2022/02/08/light-dark-toggle-for-neovim-fish-and-kitty/
function dark -d "Set dark theme"
  set -xU theme "dark"
  kitty @ set-colors -a "~/.local/share/nvim/site/pack/paqs/start/zenbones.nvim/extras/kitty/zenbones_dark.conf"
end

# set dark scheme if system is in dark mode
set scheme (gsettings get org.gnome.desktop.interface color-scheme)
if [ $scheme = "'prefer-dark'" ] && [ -z $TMUX ]
  dark
end
