## ZSH STUFF

# Path to the oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set the zsh theme
ZSH_THEME=agnoster
  # hide "user@host" when logged in as self on local machine
  export DEFAULT_USER="jamesyoung"

# PATH
fpath=(/usr/local/share/zsh-completions $fpath)
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Gists/:$PATH"

# ZSH Plugins
plugins=(
  brew
  docker
  git
  gitignore
  gnu-utils
  history-substring-search
  npm
  nvm
  pass
  z
  zsh-syntax-highlighting
)

# Enable oh-my-zsh
source $ZSH/oh-my-zsh.sh

export HISTCONTROL=ignorespace
export PATH="$HOME/.cargo/bin:$PATH"

## CUSTOM ALIASES & FUNCTIONS

# Zsh
alias zshconf="edit ~/.zshrc"

# Default editors
export EDITOR="vim"
export CVSEDITOR="vim"
export SVN_EDITOR="vim"
alias edit="/usr/local/bin/nvim"
alias vim="/usr/local/bin/nvim"
alias vi="/usr/local/bin/nvim"

export HISTCONTROL=ignorespace

alias doco="docker-compose"
alias docop="doco -f docker-compose.local.yml up -d db"
alias docod="doco down"

# Aliases for cal, ncal, calendar
export CALENDAR_DIR="${HOME}/.calendar"

# Aliases for ls, rm, and cl
alias ll="ls -lhF"
alias lla="ll -a"
alias l="ls -1"
alias la="l -a"
alias rm="rm -i"
alias cl="clear"

# Python
alias py="python3"

# Java 
export JAVA_HOME=$(/usr/libexec/java_home)

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Node.js
export NPM_TOKEN="1a280e27743eec90df78071e514ddd119f5dc78abc10d718f493d82908f21d33"
alias lintjs="semistandard --verbose | snazzy"
alias burnthemall="rm -rf node_modules package-lock.json"

# Get IP addresses
function ipg() { # global ip 
   dig +short myip.opendns.com @resolver1.opendns.com
}
function ipl() { # local ip
   ipconfig getifaddr en0
}

# Get process listing to port
function onport() {
   lsof -nP -i4TCP:"$1" | grep LISTEN
}

# Get Unix Timestamp, "YYYY-mm-DDTHHMMSS", and "YYYYmmDD-HHMMSS-msg"
alias timestamp="echo $(date +%s)"
alias datetime="echo $(date +%Y-%m-%dT%H%M%S)"

# Fuck
eval $(thefuck --alias)
alias f="fuck"

# Trans
alias trans="trans -e bing -t en"

# Todo.sh
alias todo="todo.sh"

# Git
#alias gb="git branch -a"
alias gf="echo fetching... && git fetch --prune && gb"
alias gfp="echo fetching... && git fetch --prune && gb && git pull"
alias grmm="git branch --merged | egrep -v '(master|dev)' | xargs git branch -d"
# alias gcom="git commit -m"
# alias gdel="git branch -d"
# alias glog="git log"
# alias gmerged="git branch --list -a --merged"
# alias gffd="git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d"

# Node
n() {
	NODE_V="node=$(node -v)"
	NPM_V="npm=$(npm --version)"
	NVM_V="nvm=$(nvmv)"
	echo "$NODE_V $NPM_V $NVM_V"
}

# Shortcut for opening Jira issues
jira() {
  if [ -n "$1" ] ; then
    open "https://jira.r3pi.net/browse/$1"
  else
    open "https://jira.r3pi.net/"
  fi
}

# Shortcut for opening swagger2-ui
function swagger-ui () {
  open "/Users/jamesyoung/Repos/swagger-ui-2/dist/index.html"
}

# opendb / cfdb
function opendb () {
  echo "Looking for service matching: $1"
  MATCH=$(cf apps | awk '{print $1}' | sort | grep $1 | head -1)
  echo $MATCH

  if [ -n "$MATCH" ]
    then
      echo "Found $MATCH"
      echo "Opening database with cfdb.sh now...\n"
      ~/Gists/cfdb.sh $MATCH
    else
      echo "Did not find a service matching searchstring \"$1\""
      echo "Showing list of all available services...\n"
      cf apps | awk '{print $1}' | grep -E '^[^name,^OK,^Getting].*' | sort
  fi
}

function openqr() {
  temp_file="$(mktemp -d)qr.png"
  qrencode -l H -s 5 -o $temp_file "$1" 
  open $temp_file
}

##############################################################################3
########################################################################33333##
###############################################################################

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jamesyoung/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


