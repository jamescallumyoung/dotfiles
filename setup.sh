#!/usr/bin/env sh

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

echo "${GREEN}Beginning setup.sh...${NC}"
set -e

#
# SET CONFIG VALUES
#

# these paths are relative to the repo path provided as an arg
STOW_DIR_NAME="dotfiles"

#
# GET OPTIONS -- Read Args
#

#r
OPT_REPO_PATH=""
#I
OPT_INTERACTIVE=false

#d
OPT_DO_INSTALL_DOTFILES=false
#m
OPT_DO_MISC_STEPS=false
#p
OPT_DO_INSTALL_PKGS=false
OPT_INSTALL_PKGS_WITH=""

OPTIND=1 # (A POSIX variable) reset in case getopts has been used previously in the shell

# read from the args, using getopts (from util-linux)
while getopts "r:Idp:m" opt; do
  case "$opt" in
    r)
      OPT_REPO_PATH=$OPTARG
      ;;
    I)
      OPT_INTERACTIVE=true
      ;;
    d)
      OPT_DO_INSTALL_DOTFILES=true
      ;;
    p)
      OPT_DO_INSTALL_PKGS=true
      OPT_INSTALL_PKGS_WITH=$OPTARG
      ;;
    m)
      OPT_DO_MISC_STEPS=true
      ;;
  esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

#
# GET OPTIONS -- Check Repo location is set
#

# this script needs to know the location this repo was cloned to, to find various files that will be invoked.
# the location is expected as the `-R` argument

if [ -z $OPT_REPO_PATH ]; then
  echo "${RED}You must provide the -r argument: -r \"PATH_TO_DOTFILES_REPO\". Exiting.${NC}"
  exit 1
fi

echo "${BLUE}Using repo path: $OPT_REPO_PATH${NC}"

#
# GET OPTIONS -- Vars
#

DO_INSTALL_DOTFILES=false
DO_INSTALL_PKGS=false
INSTALL_PKGS_WITH=""
DO_MISC_STEPS=false

#
# GET OPTIONS -- Interactive
#

if [ $OPT_INTERACTIVE = true ]; then
  function yesno() {
    whiptail --yesno "$1" 0 0 3>&1 1>&2 2>&3 && echo true || echo false
  }

  DO_INSTALL_DOTFILES=$(yesno "Install Dotfiles?")

  echo foo
  DO_INSTALL_PKGS=$(yesno "Install Packages?")
  echo foo2
  if [ $DO_INSTALL_PKGS = true ]; then
    echo foo3
    INSTALL_PKGS_WITH=$(whiptail --yesno "Which package manager should be used?" 0 0 3>&1 1>&2 2>&3 --no-button "Homebrew" --yes-button "Pkglist" && echo "pkglist" || echo "brew")
  fi
  echo foo4

  DO_MISC_STEPS=$(yesno "Do Misc Steps?")

  echo "(Options set with interactive. Value provided by CLI options will be ignored.)"
else
  echo "(Options set with CLI options.)"
  DO_INSTALL_DOTFILES=$OPT_DO_INSTALL_DOTFILES
  DO_MISC_STEPS=$OPT_DO_MISC_STEPS
  DO_INSTALL_PKGS=$OPT_DO_INSTALL_PKGS
  INSTALL_PKGS_WITH=$OPT_INSTALL_PKGS_WITH
fi

#
# INSTALL PACKAGES
#

if [ $DO_INSTALL_PKGS = true ]; then
  $OPT_REPO_PATH/scripts/install_pkgs.sh $OPT_REPO_PATH $INSTALL_PKGS_WITH
else
  echo "-----------------------------------------------------"
  echo "${GREEN}Skipping package install.${NC}"
  echo "${BLUE}(Enable this step with the -p flag. Disable with -P.)${NC}"
  echo "${BLUE}(The -p flag expects an argument: the package manager to use.)${NC}"
  echo "${BLUE}(Set -p to \"brew\" to use homebrew.)${NC}"
  echo "${BLUE}(Set -p to \"apt+flatpak+snap\" to use APT, Flatpak, and Snap.)${NC}"
fi

#
# SYMLINK DOTFILES WITH GNU STOW
#

if [ $DO_INSTALL_DOTFILES = true ]; then
  echo "-----------------------------------------------------"
  echo "${GREEN}Running GNU Stow for each Stow package...${NC}"

  STOW_DIR_PATH="$REPO_PATH/$STOW_DIR_NAME"
  echo "${BLUE}Using stow directory $STOW_DIR_PATH${NC}"

  # stow is invoked once for each package in ./dotfiles

  stow --dir=$STOW_DIR_PATH --target=$HOME fish
  stow --dir=$STOW_DIR_PATH --target=$HOME git
  stow --dir=$STOW_DIR_PATH --target=$HOME nvim
  stow --dir=$STOW_DIR_PATH --target=$HOME zsh

  echo "${GREEN}...done!${NC}"
else
  echo "-----------------------------------------------------"
  echo "${GREEN}Skipping dotfiles.${NC}"
  echo "${BLUE}(Enable this step with the -d flag. Disable with -D.)${NC}"
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
  
  echo "${GREEN}...done!${NC}"
else
  echo "-----------------------------------------------------"
  echo "${GREEN}Skipping misc steps.${NC}"
  echo "${BLUE}(Enable this step with the -m flag. Disable with -M.)${NC}"
fi

echo "-----------------------------------------------------"
echo "${GREEN}All steps are now complete.${NC}"
echo "${GREEN}Done!${NC}"

