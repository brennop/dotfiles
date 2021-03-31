#----------------------
#
# zsh do Brennim 😔
#
#----------------------

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

DISABLE_AUTO_UPDATE="true"

plugins=(
  git
  zsh-z
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
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# ruby
eval "$(rbenv init -)"

# android
export PATH=$HOME/Android/Sdk/emulator:$PATH
alias android="emulator @Pixel_3a_API_30_x86 -dns-server 8.8.8.8 -no-audio"

# local scripts
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# yarn
export PATH=$HOME/.yarn/bin:$PATH

