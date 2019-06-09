# dotfile versioning
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Antigen (oh-my-zsh)
source $HOME/.zsh/.antigenrc

# PATH
fpath=(/usr/local/share/zsh-completions $fpath)
export PATH="$HOME/Gists/:$PATH" # add Gists to path
if [[ "$OSTYPE" == "linux-gnu"* ]]; then # Linux
  PATH="$HOME/.local/bin:$PATH"
fi

unsetopt beep

# History
export HISTCONTROL=ignorespace
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd

# Default editors
edit() {
  if hash nvim 2>/dev/null; then
    nvim "$@"
  elif hash vim 2>/dev/null; then
    vim "$@"
  else
    vi "$@"
  fi
}
export EDITOR="nvim"

# Aliases for builtins
alias ll="ls -lhF"
alias lla="ll -a"
alias l="ls -1"
alias la="l -a"
alias rm="rm -i"
alias cl="clear"

# Restart gpg-agent
alias gpg-agent-restart="gpgconf --kill gpg-agent"

##################################################################
# UTIL FUNCTIONS #################################################

# Get global IP
function ipg() { # global ip 
   dig +short myip.opendns.com @resolver1.opendns.com
}

# Get local IP
function ipl() { # local ip
   ipconfig getifaddr en0
}

# Get process listing to port
function onport() {
   lsof -nP -i4TCP:"$1" | grep LISTEN
}

# Open Hackernews in Lynx
alias hn="lynx https://news.ycombinator.com/"

##################################################################
# APP SPECIFIC ###################################################

# calendar
export CALENDAR_DIR="${HOME}/.calendar"

# todo.sh
alias todo="todo.sh"

# Docker
alias doco="docker-compose"
alias docop="doco -f docker-compose.local.yml up -d db"
alias docod="doco down"

# Fuck
eval $(thefuck --alias)
alias f="fuck"

# twtxt
alias twtxt="twtxt -c .config/twtxt/conf"

# Git
alias gf="echo fetching... && git fetch --prune && gb"
alias gfp="echo fetching... && git fetch --prune && gb && git pull"
alias grmm="git branch --merged | egrep -v '(master|dev)' | xargs git branch -d"

##################################################################
# LANG SPECIFIC ##################################################

# Python
alias py="python3"

# Java
if [[ "$OSTYPE" == "darwin"* ]]; then # MacOS
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Node
export NPM_TOKEN="1a280e27743eec90df78071e514ddd119f5dc78abc10d718f493d82908f21d33"
function n() {
  NODE_V="node=$(node -v)"
  NPM_V="npm=$(npm --version)"
  NVM_V="nvm=$(nvmv)"
  echo "$NODE_V $NPM_V $NVM_V"
}

# Rust
export PATH="$HOME/.cargo/bin:$PATH"


##############################################################################3
##############################################################################3
##############################################################################3

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jamesyoung/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

