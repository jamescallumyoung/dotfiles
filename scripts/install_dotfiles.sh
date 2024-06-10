#!/usr/bin/env sh

#
# INSTALL DOTFILES WITH GNU STOW
#
# $1 = REPO_PATH: path to the dotfiles repo
#

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

echo "-----------------------------------------------------"
echo "${GREEN}Running GNU Stow for each Stow package...${NC}"

STOW_DIR_PATH="$REPO_PATH/dotfiles"

echo "${BLUE}Using stow directory $STOW_DIR_PATH${NC}"

# stow is invoked once for each package in ./dotfiles

stow --dir=$STOW_DIR_PATH --target=$HOME fish
stow --dir=$STOW_DIR_PATH --target=$HOME git
stow --dir=$STOW_DIR_PATH --target=$HOME nvim
stow --dir=$STOW_DIR_PATH --target=$HOME zsh

echo "${GREEN}...done!${NC}"
