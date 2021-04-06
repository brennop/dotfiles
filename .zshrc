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
  zsh-nvm
  evalcache
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# android
export PATH=$HOME/Android/Sdk/emulator:$PATH
alias android="emulator @Pixel_3a_API_30_x86 -dns-server 8.8.8.8 -no-audio"

# ytfzf
export YTFZF_EXTMENU=' rofi -dmenu -fuzzy -width 800'
alias yt="ytfzf -D"

# rofi emoji
alias emoji="rofi -show emoji"

# automatically start x
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# wal
(cat ~/.cache/wal/sequences &)
. "${HOME}/.cache/wal/colors.sh"

# nvm
# if this doesn't work make sure zsh-nvm is installed
# https://github.com/lukechilds/zsh-nvm#as-an-oh-my-zsh-custom-plugin
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# ruby
_evalcache rbenv init -

# local scripts
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# yarn
export PATH=$HOME/.yarn/bin:$PATH

