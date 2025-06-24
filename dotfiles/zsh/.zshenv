
# This file is sourced in both interactive and non-interactive shells, wheras .zshrc is only
# sourced for interactive shells. We set env vars here that should be loaded by all programs.

export VISUAL=vim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

export PAGER=less


# Ensure path arrays do not contain duplicates.
typeset -gU path fpath


#
# OS_PM
#

macos_use_homebrew=1
linux_use_homebrew=1
source ~/.config/zsh/set-os-pm.zsh
set_os_pm


#
# brew
#

case $OS_PM in
"Darwin__homebrew")
    case "$(uname -m)" in
    "arm64")
        # macOS -- apple silicon
        eval $(/opt/homebrew/bin/brew shellenv) ;;
    "x86_64")
        # macOS -- intel
        eval $(/usr/local/bin/brew shellenv) ;;
    *)
        echo "Unknown MacOS architecture. Homebrew could not be set up. System may not behave as expected." ;;
    esac
    ;;
"Linux__apt,homebrew" | "Linux__unknown,homebrew")
    eval $(/home/linuxbrew/.linuxbrew shellenv) ;;
# add additional "Linux__" values here as they are added to OS_PM
*)
    echo "No valid homebrew configs available for OS_PM=${OS_PM}. Homebrew could not be set up. System may not behave as expected."
    echo "Note: If this is a Linux OS, it may be trivial to enable homebrew support. See ~/.zshenv"
    ;;
esac


#
# Node.js -- set up fnm (Node.js "fast package manager")
# (note: also enables corepack, so yarn and pnpm are available)
#

case $OS_PM in
"Darwin__homebrew")
    # fnm is installed with brew if brew is available. brew paths should already be in PATH
    eval "$(fnm env --use-on-cd --version-file-strategy recursive --corepack-enabled --resolve-engines --shell zsh)"
    ;;
"Linux__apt" | "Linux__apt,homebrew" | "Linux__unknown" | "Linux__unknown,homebrew")
    path+=("$XDG_DATA_HOME/fnm")
    eval "$(fnm env --use-on-cd --version-file-strategy recursive --corepack-enabled --resolve-engines --shell zsh)"
    ;;
*)
    echo "No configuration provided for OS_PM ${OS_PM}. fnm could not be set up. Node, npm, yarn, and pnpm may not be available. System may not behave as expected." ;;
esac


#
# Liquibase
#

case $OS_PM in
"Darwin__homebrew")
    LIQUIBASE_HOME="$(brew --prefix)/opt/liquibase/libexec" ;;
esac


#
# macOS -- Setting up GNU utils
# (note: no longer requires _evalcache to be in the path first)
#

if [[ $OS_PM == "Darwin__homebrew" ]]; then
    source ~/.config/zsh/setup-macos-gnu-utils.zsh
fi
