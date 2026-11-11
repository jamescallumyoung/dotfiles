#!/bin/sh
# install-dotfiles.sh
#
# Symlink dotfile packages into $HOME using GNU Stow.
#
# Usage:
#   ./install-dotfiles.sh
#
# POSIX sh — no bashisms.

set -eu

SCRIPT_DIR="$(cd "$(dirname -- "$0")" && pwd)"
. "$SCRIPT_DIR/lib/log.sh"

log_primary "[install-dotfiles.sh] Starting"

# ---------------------------------------------------------------------------
# Stow each dotfile package
# ---------------------------------------------------------------------------

repo_path="$(cd "$SCRIPT_DIR/.." && pwd)"
stow_dir="$repo_path/dotfiles"
log_secondary "[install-dotfiles.sh] Stowing dotfile packages from $stow_dir ..."

log_secondary "[install-dotfiles.sh] ... fish"
stow --dir="$stow_dir" --target="$HOME" fish

log_secondary "[install-dotfiles.sh] ... git"
stow --dir="$stow_dir" --target="$HOME" git

log_secondary "[install-dotfiles.sh] ... nvim"
stow --dir="$stow_dir" --target="$HOME" nvim

log_secondary "[install-dotfiles.sh] ... ssh"
stow --dir="$stow_dir" --target="$HOME" ssh

log_secondary "[install-dotfiles.sh] ... zsh"
stow --dir="$stow_dir" --target="$HOME" zsh

log_secondary "[install-dotfiles.sh] Done"
