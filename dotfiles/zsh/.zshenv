
# This file is sourced in both interactive and non-interactive shells, wheras .zshrc is only
# sourced for interactive shells. We set env vars here that should be loaded by all programs.

export VISUAL=vim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

export PAGER=less


#
# brew
#

if [[ $(uname) == "Darwin" && $(uname -m) == 'arm64' ]]; then # macOS -- apple silicon
    eval $(/opt/homebrew/bin/brew shellenv)

elif [[ $(uname) == "Darwin" && $(uname -m) == 'x86_64' ]]; then # macOS -- intel
    eval $(/usr/local/bin/brew shellenv)

elif command -v apt > /dev/null; then # debian linux
    eval $(/home/linuxbrew/.linuxbrew shellenv)

else
    echo 'Unknown OS!'
    echo "COULDN'T LOAD HOMEBREW"
fi


#
# macOS -- Setting up GNU utils
# (note: no longer requires _evalcache to be in the path first)
#

if [[ $(uname) == "Darwin" ]]; then # macOS
    source ~/.config/zsh/setup-macos-gnu-utils.zsh
fi

