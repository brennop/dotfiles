#----------------------
#
# zsh do Brennim 😔
#
#----------------------

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

DISABLE_AUTO_UPDATE="true"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias py="python3"

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# wal
(cat ~/.cache/wal/sequences &)
. "${HOME}/.cache/wal/colors.sh"

# nvm
source /usr/share/nvm/init-nvm.sh

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
