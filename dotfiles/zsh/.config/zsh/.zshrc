
# note: compinit removed; handled by a plugin

# set up antidote, a modern reimplementation of antigen/antibody
# antidote is a package manageer for zsh plugins
#
case $OS_PM in
"Darwin__homebrew")
    SPACESHIP_DIR_TRUNC_REPO=false # config for spaceship
    SPACESHIP_GCLOUD_SHOW=false
    source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
    antidote load # loads plugins from ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
    ;;
*)
    echo "Antidote (zsh Antigen clone) not loaded! No configs found for OS_PM=${OS_PM}. System may not behave as expected." ;;
esac

# terminal options; disable beeping
unsetopt beep

# note: history configs removed; handled by a plugin

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

# Aliases for Kubernetes
alias k="kubectl"
alias kx="kubectx"
alias kns="kubens"

# Other Aliases
alias webs="webstorm ./"
alias idea="idea ./"
alias tf="terraform"

tre() { touch "/tmp/tre_aliases_$USER" && command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

# we store the current version of node so that coc.nvim can find it (coc.nvim cannot call nvm directly)
export NVM_CURRENT_ON_START=$(which node)


#
# paths
#

path+=("/usr/local/bin")


# add shortcut commands for jetbrains toolbox apps
if [[ $(uname) == "Darwin" ]]; then # macOS
    path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")
fi


#
# eval caching -- we cache some "eval"s to improve performance
#
source ~/.config/zsh/setup-eval-caching.zsh


# Aliases for grep -- we want to use ugrep instead
alias grep="ugrep -G"
alias egrep="ugrep -E"
alias fgrep="ugrep -F"


#
# additional zsh completions
#

# fzf completions
source <(fzf --zsh)

# git-extras completions
if [[ $(uname) == "Darwin" ]]; then # macOS
    source $(brew --prefix)/opt/git-extras/share/git-extras/git-extras-completion.zsh
fi

