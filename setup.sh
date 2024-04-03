#!/usr/bin/env sh

echo "Beginning setup.sh..."
set -e

#
# SET CONFIG VALUES
#

# these paths are relative to the repo path provided as an arg
MAIN_BREWFILE="pkg-lists/brew/main.brewfile"
STOW_DIR_NAME="dotfiles"

##
## GET REPO LOCATION FROM ARGS
##

# this script needs to know the location this repo was cloned to, to find various files that will be invoked.
# the location is expected as the `-R` argument

OPTIND=1 # (A POSIX variable) reset in case getopts has been used previously in the shell

REPO_PATH=""
INSTALL_PKGS_WITH=""
DO_INSTALL_DOTFILES=false
DO_INSTALL_PKGS=false
DO_MISC_STEPS=false

# read from the args, using getopts (from util-linux)
while getopts "r:dDmMp:P" opt; do
  case "$opt" in
    r)
      REPO_PATH=$OPTARG
      ;;
    d)
      DO_INSTALL_DOTFILES=true
      ;;
    D)
      DO_INSTALL_DOTFILES=false
      ;;
    m)
      DO_MISC_STEPS=true
      ;;
    M)
      DO_MISC_STEPS=false
      ;;
    p)
      DO_INSTALL_PKGS=true
      INSTALL_PKGS_WITH=$OPTARG
      ;;
    P)
      DO_INSTALL_PKGS=false
      INSTALL_PKGS_WITH=""
      ;;
  esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

if [ -z $REPO_PATH ]; then
  echo "You must provide the -r argument: -r \"PATH_TO_DOTFILES_REPO\". Exiting."
  exit 1
fi

echo "Using repo path: $REPO_PATH"

#
# INSTALL PACKAGES WITH BREW
#

if [ $DO_INSTALL_PKGS = true ]; then
  case "$INSTALL_PKGS_WITH" in
    brew)
      MAIN_BREWFILE_PATH="$REPO_PATH/$MAIN_BREWFILE"
      echo "-----------------------------------------------------"
      echo "Installing Homebrew packages from $MAIN_BREWFILE_PATH"
      echo "Note: any failed installs should be manually corrected after this script has run"
      echo "This step may take some time..."
      cat $MAIN_BREWFILE_PATH | brew bundle install --file=-
      ;;
    *)
      echo "-----------------------------------------------------"
      echo "Cannot install packages. Specified package manager is not supported."
      echo "Package manager is: \"$INSTALL_PKGS_WITH\"."
  esac
else
  echo "-----------------------------------------------------"
  echo "Skipping package install."
  echo "(Enable this step with the -p flag. Disable with -P.)"
  echo "(The -p flag expects an argument; the package manager to use."
  echo "(Set -p to "brew" to use homebrew.)"
fi

#
# SYMLINK DOTFILES WITH GNU STOW
#

if [ $DO_INSTALL_DOTFILES = true ]; then
  echo "-----------------------------------------------------"
  echo "Running GNU Stow for each Stow package..."

  STOW_DIR_PATH="$REPO_PATH/$STOW_DIR_NAME"
  echo "using stow directory $STOW_DIR_PATH"

  # stow is invoked once for each package in ./dotfiles

  stow --dir=$STOW_DIR_PATH --target=$HOME fish
  stow --dir=$STOW_DIR_PATH --target=$HOME git
  stow --dir=$STOW_DIR_PATH --target=$HOME node
  stow --dir=$STOW_DIR_PATH --target=$HOME nvim
  stow --dir=$STOW_DIR_PATH --target=$HOME zsh
else
  echo "-----------------------------------------------------"
  echo "Skipping dotfiles."
  echo "(Enable this step with the -d flag. Disable with -D.)"
fi

#
# CHANGE DEFAULT SHELL TO ZSH
#

if [ $DO_MISC_STEPS = true ]; then
  echo "-----------------------------------------------------"
  echo "Changing default user shell to zsh..."

  # assumes 'which zsh' will return brew's zsh. (it should!) you can check with 'brew doctor'
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh -s $(which zsh)
else
  echo "-----------------------------------------------------"
  echo "Skipping misc steps."
  echo "(Enable this step with the -m flag. Disable with -M.)"
fi

echo "-----------------------------------------------------"
echo "Done!"
