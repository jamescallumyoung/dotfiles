#!/usr/bin/env sh

#
# CHANGE THE DEFAULT SHELL TO ZSH
#

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
log_primary "Changing default user shell to zsh..."

# assumes 'which zsh' will return brew's zsh. (it should!) you can check with 'brew doctor'
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

log_primary "...done!"
