# This file is sourced in both interactive and non-interactive shells, wheras .zshrc is only
# sourced for interactive shells. We set env vars here that should be loaded by all programs.

export VISUAL=vim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

export PAGER=less
