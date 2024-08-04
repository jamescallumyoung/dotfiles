#!/usr/bin/env sh

#
# INSTALL DOTFILES WITH GNU STOW
#
# $1 = REPO_PATH: path to the dotfiles repo
#

REPO_PATH=$1

NC='\033[0m' # No color
log_primary() {
  echo "\033[0;32m$1${NC}"
}
log_secondary() {
  echo "\033[0;37m$1${NC}"
}
log_error() {
  echo "\033[0;31m$1${NC}"
}

echo "-----------------------------------------------------"
log_primary "Running GNU Stow for each Stow package..."

STOW_DIR_PATH="$REPO_PATH/dotfiles"

log_secondary "Using stow directory $STOW_DIR_PATH"

# stow is invoked once for each package in ./dotfiles

stow --dir=$STOW_DIR_PATH --target=$HOME fish
stow --dir=$STOW_DIR_PATH --target=$HOME git
stow --dir=$STOW_DIR_PATH --target=$HOME nvim
stow --dir=$STOW_DIR_PATH --target=$HOME ssh
stow --dir=$STOW_DIR_PATH --target=$HOME zsh

log_primary "...done!"
