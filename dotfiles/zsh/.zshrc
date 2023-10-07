# setup antigen first
source $(brew --prefix)/share/antigen/antigen.zsh
antigen init $HOME/.antigenrc

# terminal options; disable beeping
unsetopt beep

# History
export HISTCONTROL=ignorespace
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd

#
# paths
#

# add shortcut commands for jetbrains toolbox apps
path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")

# Aliases for builtins
alias ll="ls -lhF"
alias l="ls -1"
alias la="l -a"
alias cl="clear"

# Fuck
eval $(thefuck --alias)
alias f="fuck"

# hub (GitHub cli)
eval "$(hub alias -s)"


