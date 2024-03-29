# setup antigen first
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
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

# Other Aliases
alias webs="webstorm ./"
alias idea="idea ./"
alias tf="terraform"

#
# setup eval caching (lazy-loading) for tool that need `eval`ing 
# (cached `eval`s can be cleared with `$ _evalcache_clear`)
#

# nvm
# nothing to do; we use the zsh-nvm plugin to layz-load nvm

# thefuck
_evalcache thefuck --alias
alias f="fuck"

# hub (GitHub cli)
_evalcache hub alias -s

# jenv; java environment manager
export PATH="$HOME/.jenv/bin:$PATH"
_evalcache jenv init -

#
# other confs
#

# liquibase
LIQUIBASE_HOME="/opt/homebrew/opt/liquibase/libexec"

#
# zsh completions
#

# fzf completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# git-extras completions
source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh

