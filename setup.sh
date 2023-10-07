#!/usr/bin/env sh

#
# SET CONFIG VALUES
#

# these paths are relative to the repo path provided as an arg
MAIN_BREWFILE="brewfiles/main.brewfile"
STOW_DIR_NAME="dotfiles/"

##
## GET REPO LOCATION FROM ARGS
##

# this script needs to know the location this repo was cloned to, to find various files that will be invoked.
# the location is expected as the `-R` argument

OPTIND=1 # (A POSIX variable) reset in case getopts has been used previously in the shell

REPO_PATH=""

# read from the args, using getopts (from util-linux)
while getopts "R:" opt; do
  case "$opt" in
    R)
      REPO_PATH=$OPTARG
    ;;
  esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

echo "repo path = $REPO_PATH"

#
# INSTALL PACKAGES WITH BREW
#

MAIN_BREWFILE_PATH="$REPO_PATH/$MAIN_BREWFILE"
cat $MAIN_BREWFILE_PATH | brew bundle install --file=-

#
# SYMLINK DOTFILES WITH GNU STOW
#

$STOW_DIR_PATH = "$REPO_PATH/$STOW_DIR"

# stow is invoked once for each package in ./dotfiles

stow --dir $STOW_DIR_PATH --target $HOME fish
stow --dir $STOW_DIR_PATH --target $HOME git
stow --dir $STOW_DIR_PATH --target $HOME node
stow --dir $STOW_DIR_PATH --target $HOME zsh

#
# CHANGE DEFAULT SHELL TO ZSH
#

# assumes 'which zsh' will return brew's zsh. (it should!) you can check with 'brew doctor'
sudo sh -c "echo $(which zsh) >> /etc/shells"
$ chsh -s $(which zsh)