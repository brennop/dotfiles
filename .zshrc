# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pst/.zshrc'

autoload -Uz compinit
compinit

alias py=python3

#wal
(cat ~/.cache/wal/sequences &)

# Import the colors.
. "${HOME}/.cache/wal/colors.sh"

# Create the alias.
#alias dmen='dmenu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15"'

#add zprezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

#modules
# End of lines added by compinstall
