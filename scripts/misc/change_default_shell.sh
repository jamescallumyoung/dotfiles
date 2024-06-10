#!/usr/bin/env sh

#
# CHANGE THE DEFAULT SHELL TO ZSH
#

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

echo "-----------------------------------------------------"
echo "${GREEN}Changing default user shell to zsh...${NC}"

# assumes 'which zsh' will return brew's zsh. (it should!) you can check with 'brew doctor'
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

echo "${GREEN}...done!${NC}"
