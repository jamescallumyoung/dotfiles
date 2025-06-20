
# note: compinit removed; handled by a plugin

# set up antidote, a modern reimplementation of antigen/antibody
# antidote is a package manageer for zsh plugins
#
if [[ $(uname) == "Darwin" ]]; then # macOS
    SPACESHIP_DIR_TRUNC_REPO=false # config for spaceship
    SPACESHIP_GCLOUD_SHOW=false
    source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
    antidote load # loads from ~/.zsh_plugins.txt
else
    echo "Unknown OS!"
    echo "Antidote (zsh Antigen clone) not loaded!"
fi

# terminal options; disable beeping
unsetopt beep

# note: history configs removed; handled by a plugin

# Aliases for builtins
alias ll="ls -lhF"
alias l="ls -1"
alias la="l -a"
alias cl="clear"

# Aliases for Vim
alias vi="nvim"
alias vim="nvim"

# Other Aliases
alias webs="webstorm ./"
alias idea="idea ./"
alias tf="terraform"
alias k="kubectl"

tre() { touch "/tmp/tre_aliases_$USER" && command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

# we store the current version of node so that coc.nvim can find it (coc.nvim cannot call nvm directly)
export NVM_CURRENT_ON_START=$(which node)


#
# paths
#

# for liquibase
if [[ $(uname) == "Darwin" ]]; then # macOS
    LIQUIBASE_HOME="$(brew --prefix)/opt/liquibase/libexec"
fi

# for golang
export GOPATH="$HOME/.gopath"   # my code -- usually ~/go but I prefer to use a hidden dir
export GOROOT="$HOME/.go"       # golang source code
path+=("$GOPATH/bin")           # my code, built and executable

# for yarn
# (yarn global path set in .yarnrc)
path+=("$HOME/.yarn/bin")

# add shortcut commands for jetbrains toolbox apps
# for liquibase
if [[ $(uname) == "Darwin" ]]; then # macOS
    path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")
fi

# for node - fnm
if [ $(uname) = "Linux" ]; then
    path+=("$XDG_DATA_HOME/fnm")
    eval "$(fnm env --use-on-cd --version-file-strategy recursive --corepack-enabled --resolve-engines --shell zsh)"
elif [ $(uname) = "Darwin" ]; then
    # fnm installed with brew in macOS. brew paths should already be in PATH
    eval "$(fnm env --use-on-cd --version-file-strategy recursive --corepack-enabled --resolve-engines --shell zsh)"
else
    echo "No configuration provided for OS $(uname). fnm could not be set up.."
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

