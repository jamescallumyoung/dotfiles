
# note: compinit and history setting handled by plugins

# set up antidote, a modern reimplementation of antigen/antibody
# antidote is a package manageer for zsh plugins
#
if using_pm "brew"; then
    SPACESHIP_DIR_TRUNC_REPO=false # config for spaceship
    SPACESHIP_GCLOUD_SHOW=false
    source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
    antidote load # loads plugins from ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
else
    echo "Antidote (zsh Antigen clone) not loaded! No configs found for OS_PM=${OS_PM}. System may not behave as expected."
fi

# terminal options; disable beeping
unsetopt beep


# Aliases for builtins
alias ll="ls -lhF"
alias l="ls -1"
alias la="l -a"
alias cl="clear"
alias ..="cd .."
alias ...="cd ../.."

# Aliases for Vim
alias vi="nvim"
alias vim="nvim"

# Aliases for grep -- we want to use ugrep instead
alias grep="ugrep -G"
alias egrep="ugrep -E"
alias fgrep="ugrep -F"

# Aliases for Kubernetes
alias k="kubectl"
alias kx="kubectx"
alias kns="kubens"

# Other Aliases
alias webs="webstorm ./"
alias idea="idea ./"
alias tf="terraform"
alias f="thefuck"


#
# other commands that need setting up
# Note: some commands are set up with "eval caching" (lazy-loading): this helps improve shell startup times
# (cached `eval`s can be cleared with `$ _evalcache_clear`)
#

# thefuck
_evalcache thefuck --alias

# hub (GitHub cli)
_evalcache hub alias -s

# fzf completions
source <(fzf --zsh)

# git-extras completions
if [[ $(uname) == "Darwin" ]]; then # macOS
    source $(brew --prefix)/opt/git-extras/share/git-extras/git-extras-completion.zsh
fi

# add shortcut commands for jetbrains toolbox apps
if [[ $(uname) == "Darwin" ]]; then # macOS
    path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")
fi
