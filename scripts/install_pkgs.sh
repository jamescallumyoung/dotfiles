#!/usr/bin/env sh

#
# INSTALL PACKAGES WITH BREW OR PKGLIST
#
# $1 = REPO_PATH: path to the dotfiles repo
# $2 = PKG_MANAGER: the package manager to use; either "brew" or "pkglist"
#

REPO_PATH=$1
PKG_MANAGER=$2

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

case "$PKG_MANAGER" in
  brew)
    FILE="$REPO_PATH/pkg-lists/brewfiles/main.brewfile"

    echo "-----------------------------------------------------"
    echo "${GREEN}Installing Packages...${NC}"
    echo "${BLUE}Using homebrew.${NC}"
    echo "${BLUE}From brewfile $FILE.${NC}"
    echo "${BLUE}This step may take some time...${NC}"

    cat $FILE | brew bundle install --file=-

    echo "${GREEN}...done!${NC}"
    echo "${BLUE}Note: any failed installs should be manually corrected after this script has run.${NC}"
    ;;

  pkglist)
    FILE="$REPO_PATH/pkg-lists/pkglists/main.pkglist"

    echo "-----------------------------------------------------"
    echo "${GREEN}Installing Packages...${NC}"
    echo "${BLUE}Using pkglist-cli (APT, Flatpak, and Snap).${NC}"
    echo "${BLUE}From pkglist $REPO_PATH.${NC}"
    echo "${BLUE}This step may take some time...${NC}"

    # setup

    echo "${BLUE}--- pkglist ---${NC}"
    sudo npm i -g pkglist-cli

    # APT

    echo "${BLUE}--- apt (repos) ---${NC}"
    sudo apt update
    cat $FILE | pkglist parse -Up apt-repo \
        | xargs $(pkglist get-script -p apt-repo -ys)

    echo "${BLUE}--- apt ---${NC}"
    sudo apt update
    cat $FILE | pkglist parse -Up apt \
        | xargs $(pkglist get-script -p apt -ys)

    # note: snap and flatpak are currently unable to install multiple
    #       packages at once. we have to invoke the install commands once for
    #       each package.
    #
    # note: snap and flatpak both error if the package isn't available in the
    #       current architecture, so we must disable `set -e`

    # Flatpak

    echo "${BLUE}--- flatpak ---${NC}"
    set +e
    cat $FILE | pkglist parse -Up flatpak \
        | awk '{OFS=ORS; $1=$1}1' \
        | while read line ; do $(pkglist get-script -p flatpak -ys) $line ; done
    set -e

    # Snap

    echo "${BLUE}--- snap ---${NC}"
    set +e
    cat $FILE | pkglist parse -Up snap \
        | awk '{OFS=ORS; $1=$1}1' \
        | while read line ; do $(pkglist get-script -p snap -ys) $line ; done
    set -e

    echo "${BLUE}--- snap --classic ---${NC}"
    set +e
    cat $FILE | pkglist parse -Up snap-classic \
        | awk '{OFS=ORS; $1=$1}1' \
        | while read line ; do $(pkglist get-script -p snap-classic -ys) $line ; done
    set -e

    echo "${GREEN}...done!${NC}"
    echo "${BLUE}Note: any failed installs should be manually corrected after this script has run.${NC}"

    ;;
  *)
    echo "-----------------------------------------------------"
    echo "${RED}Cannot install packages. Specified package manager is not supported.${NC}"
    echo "${RED}Package manager is: \"$PKG_MANAGER\".${NC}"
    echo "${RED}Supported managers are: \"brew\" and \"pkglist\".${NC}"
esac
