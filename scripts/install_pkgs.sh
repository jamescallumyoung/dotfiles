#!/usr/bin/env sh

#
# INSTALL PACKAGES WITH BREW OR PKGLIST
#
# $1 = REPO_PATH: path to the dotfiles repo
# $2 = PKG_MANAGER: the package manager to use; either "brew" or "pkglist"
#

REPO_PATH=$1
PKG_MANAGER=$2

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

case "$PKG_MANAGER" in
  brew)
    FILE="$REPO_PATH/pkg-lists/brewfiles/main.brewfile"

    echo "-----------------------------------------------------"
    log_primary "Installing Packages..."
    log_secondary "Using homebrew."
    log_secondary "From brewfile $FILE."
    log_secondary "This step may take some time..."

    cat $FILE | brew bundle install --file=-

    log_primary "...done!"
    log_secondary "Note: any failed installs should be manually corrected after this script has run."

    ;;
  pkglist)
    FILE="$REPO_PATH/pkg-lists/pkglists/main.pkglist"

    echo "-----------------------------------------------------"
    log_primary "Installing Packages..."
    log_secondary "Using pkglist-cli (APT, Flatpak, and Snap)."
    log_secondary "From pkglist $REPO_PATH."
    log_secondary "This step may take some time..."

    # setup

    log_secondary "--- pkglist ---"
    sudo npm i -g pkglist-cli

    # APT

    log_secondary "--- apt (repos) ---"
    sudo apt update
    cat $FILE | pkglist parse -Up apt-repo \
        | xargs $(pkglist get-script -p apt-repo -ys)

    log_secondary "--- apt ---"
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

    log_secondary "--- flatpak ---"
    set +e
    cat $FILE | pkglist parse -Up flatpak \
        | awk '{OFS=ORS; $1=$1}1' \
        | while read line ; do $(pkglist get-script -p flatpak -ys) $line ; done
    set -e

    # Snap

    log_secondary "--- snap ---"
    set +e
    cat $FILE | pkglist parse -Up snap \
        | awk '{OFS=ORS; $1=$1}1' \
        | while read line ; do $(pkglist get-script -p snap -ys) $line ; done
    set -e

    log_secondary "--- snap --classic ---"
    set +e
    cat $FILE | pkglist parse -Up snap-classic \
        | awk '{OFS=ORS; $1=$1}1' \
        | while read line ; do $(pkglist get-script -p snap-classic -ys) $line ; done
    set -e

    log_primary "...done!"
    log_secondary "Note: any failed installs should be manually corrected after this script has run."

    ;;
  *)
    echo "-----------------------------------------------------"
    log_error "Cannot install packages. Specified package manager is not supported."
    log_error "Package manager is: \"$PKG_MANAGER\"."
    log_error "Supported managers are: \"brew\" and \"pkglist\"."
esac
