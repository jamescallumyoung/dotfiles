#!/usr/bin/env sh

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

echo "${GREEN}Beginning setup.sh...${NC}"
set -e

#
# SET CONFIG VALUES
#

# these paths are relative to the repo path provided as an arg
MAIN_BREWFILE="pkg-lists/brewfiles/main.brewfile"
MAIN_PKGLIST="pkg-lists/pkglists/main.pkglist"
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
  echo "${RED}You must provide the -r argument: -r \"PATH_TO_DOTFILES_REPO\". Exiting.${NC}"
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
      echo "${GREEN}Installing Packages...${NC}"
      echo "Using homebrew"
      echo "From brewfile $MAIN_BREWFILE_PATH."
      echo "This step may take some time..."

      cat $MAIN_BREWFILE_PATH | brew bundle install --file=-

      echo "...done!"
      echo "Note: any failed installs should be manually corrected after this script has run."
      ;;
    pkglist)
      MAIN_PKGLIST_PATH="$REPO_PATH/$MAIN_PKGLIST"
      echo "-----------------------------------------------------"
      echo "${GREEN}Installing Packages...${NC}"
      echo "Using pkglist-cli (APT, Flatpak, and Snap)"
      echo "From pkglist $MAIN_PKGLIST_PATH."
      echo "This step may take some time..."

      npm i -g pkglist-cli
      cat $MAIN_PKGLIST_PATH | pkglist parse -Up apt | xargs echo $(pkglist get-command -p apt)
      cat $MAIN_PKGLIST_PATH | pkglist parse -Up flatpak | xargs echo $(pkglist get-command -p flatpak)
      cat $MAIN_PKGLIST_PATH | pkglist parse -Up snap | xargs echo $(pkglist get-command -p snap)
      cat $MAIN_PKGLIST_PATH | pkglist parse -Up snap-classic | xargs echo $(pkglist get-command -p snap-classic)

      echo "...done!"
      echo "Note: any failed installs should be manually corrected after this script has run"

      ;;
    *)
      echo "-----------------------------------------------------"
      echo "${RED}Cannot install packages. Specified package manager is not supported.${NC}"
      echo "${RED}Package manager is: \"$INSTALL_PKGS_WITH\".${NC}"
      echo "${RED}Supported managers are: \"brew\" and \"pkglist\".${NC}"
  esac
else
  echo "-----------------------------------------------------"
  echo "${GREEN}Skipping package install.${NC}"
  echo "(Enable this step with the -p flag. Disable with -P.)"
  echo "(The -p flag expects an argument: the package manager to use.)"
  echo "(Set -p to \"brew\" to use homebrew.)"
  echo "(Set -p to \"apt+flatpak+snap\" to use APT, Flatpak, and Snap.)"
fi

#
# SYMLINK DOTFILES WITH GNU STOW
#

if [ $DO_INSTALL_DOTFILES = true ]; then
  echo "-----------------------------------------------------"
  echo "${GREEN}Running GNU Stow for each Stow package...${NC}"

  STOW_DIR_PATH="$REPO_PATH/$STOW_DIR_NAME"
  echo "Using stow directory $STOW_DIR_PATH"

  # stow is invoked once for each package in ./dotfiles

  stow --dir=$STOW_DIR_PATH --target=$HOME fish
  stow --dir=$STOW_DIR_PATH --target=$HOME git
  stow --dir=$STOW_DIR_PATH --target=$HOME nvim
  stow --dir=$STOW_DIR_PATH --target=$HOME zsh
else
  echo "-----------------------------------------------------"
  echo "${GREEN}Skipping dotfiles.${NC}"
  echo "(Enable this step with the -d flag. Disable with -D.)"
fi

#
# CHANGE DEFAULT SHELL TO ZSH
#

if [ $DO_MISC_STEPS = true ]; then
  echo "-----------------------------------------------------"
  echo "${GREEN}Changing default user shell to zsh...${NC}"

  # assumes 'which zsh' will return brew's zsh. (it should!) you can check with 'brew doctor'
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh -s $(which zsh)
else
  echo "-----------------------------------------------------"
  echo "${GREEN}Skipping misc steps.${NC}"
  echo "(Enable this step with the -m flag. Disable with -M.)"
fi

echo "-----------------------------------------------------"
echo "${GREEN}Done!${NC}"

