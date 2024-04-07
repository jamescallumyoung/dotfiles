# use the compinit fn to enable zsh's advanced completion system.
# this should be done once, and early.
# running multiple times can cause significant slowdown.
autoload -Uz compinit && compinit

# setup antigen first
if [[ $(uname) == "Darwin" ]]; then
    # macOS
    fpath+=("$(brew --prefix)/share/zsh/site-functions")
    source $(brew --prefix)/share/antigen/antigen.zsh
    antigen init $HOME/.antigenrc

elif command -v apt > /dev/null; then
    # debian linux
    fpath+=("/usr/local/share/zsh/site-functions")
    source $(dpkg -L zsh-antigen | grep antigen.zsh)
    antigen init $HOME/.antigenrc

else
    echo 'Unknown OS!'
    echo 'zsh could not be set up correctly.'
    echo 'antigen could not be set up correctly.'
fi

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

# add paths for golang
export GOPATH="$HOME/.gopath"   # my code -- usually ~/go but I prefer to use a hidden dir
export GOROOT="$HOME/.go"       # golang source code
path+=("$GOPATH/bin")           # my code, built and executable

# add paths for yarn
# (yarn global path set in .yarnrc)
path+=("$HOME/.yarn/bin")

# add shortcut commands for jetbrains toolbox apps
path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")

# Aliases for builtins
alias ll="ls -lhF"
alias l="ls -1"
alias la="l -a"
alias cl="clear"

# Aliases for grep
alias grep="ugrep -G"
alias egrep="ugrep -E"
alias fgrep="ugrep -F"

if [[ $(uname) == "Darwin" ]]; then
    # on macOS, use the GNU versions provided by brew
    # Get list of gnubin directories
    GNUBINS="$(find $(brew --prefix)/opt -type d -follow -name gnubin -print)";
    
    for bindir in ${GNUBINS[@]}; do
        export path=($bindir $path) # prepend so they take prio
    done;
fi

# Aliases for Vim
alias vi="nvim"
alias vim="nvim"

# Other Aliases
alias webs="webstorm ./"
alias idea="idea ./"
alias tf="terraform"

tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

#
# setup eval caching (lazy-loading) for tool that need `eval`ing 
# (cached `eval`s can be cleared with `$ _evalcache_clear`)
#

# nvm
# nothing to do; we use the zsh-nvm plugin to layz-load nvm
export NVM_CURRENT_ON_START=$(nvm which current)

# thefuck
_evalcache thefuck --alias
alias f="fuck"

# hub (GitHub cli)
_evalcache hub alias -s

# jenv; java environment manager
path+=("$HOME/.jenv/bin")
_evalcache jenv init -

#
# other confs
#

# liquibase
if [[ $(uname) == "Darwin" ]]; then
    # macOS
    LIQUIBASE_HOME="$(brew --prefix)/opt/liquibase/libexec"
fi

#
# zsh completions
#

# fzf completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# git-extras completions
if [[ $(uname) == "Darwin" ]]; then
    # macOS
    source ${brew --prefix}/opt/git-extras/share/git-extras/git-extras-completion.zsh
fi

