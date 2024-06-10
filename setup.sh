#!/usr/bin/env sh

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

log_primary "Beginning setup.sh..."
set -e

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
  log_error "You must provide the -r argument: -r \"PATH_TO_DOTFILES_REPO\". Exiting."
  exit 1
fi

log_secondary "Using repo path: $OPT_REPO_PATH"

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

  DO_INSTALL_PKGS=$(yesno "Install Packages?")
  if [ $DO_INSTALL_PKGS = true ]; then
    INSTALL_PKGS_WITH=$(whiptail --yesno "Which package manager should be used?" 0 0 3>&1 1>&2 2>&3 --no-button "Homebrew" --yes-button "Pkglist" && echo "pkglist" || echo "brew")
  fi

  DO_MISC_STEPS=$(yesno "Do Misc Steps?")

  log_secondary "Options set with interactive. Value provided by CLI options will be ignored."
else
  log_secondary "Options set with CLI options."
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
  log_primary "Skipping package install."
  log_secondary "(Enable this step with the -p flag. Disable with -P.)"
  log_secondary "(The -p flag expects an argument: the package manager to use.)"
  log_secondary "(Set -p to \"brew\" to use homebrew.)"
  log_secondary "(Set -p to \"apt+flatpak+snap\" to use APT, Flatpak, and Snap.)"
fi

#
# INSTALL DOTFILES
#

if [ $DO_INSTALL_DOTFILES = true ]; then
  $OPT_REPO_PATH/scripts/install_dotfiles.sh $OPT_REPO_PATH
else
  echo "-----------------------------------------------------"
  log_primary "Skipping dotfiles."
  log_secondary "(Enable this step with the -d flag. Disable with -D.)"
fi

#
# MISC STEPS
# (These are additional misc steps that we may want to perform when setting up a system.)
#

if [ $DO_MISC_STEPS = true ]; then
  $OPT_REPO_PATH/scripts/misc/change_default_shell.sh
else
  echo "-----------------------------------------------------"
  log_secondary "Skipping misc steps."
  log_secondary "(Enable this step with the -m flag. Disable with -M.)"
fi

echo "-----------------------------------------------------"
log_secondary "All steps are now complete."
log_primary "Done!"
