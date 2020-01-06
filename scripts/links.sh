#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR="$( cd "$( dirname "$SCRIPTS" )" && pwd )"

# Include helpers
source "$SCRIPTS/helpers.sh"

link_folder "$DOTFILES_DIR"
[ ! -d "$HOME/.config" ] && mkdir "$HOME/.config"
link_folder "$DOTFILES_DIR/config" "*" "$HOME/.config"

if [[ "$PREFIX" = "com.termux" ]]; then
	# Might need a more reliable way of checking for termux.
	# This works for now
	link_folder "$DOTFILES_DIR/android"
elif [ "$(uname)" == "Linux" ]; then
	link_folder "$DOTFILES_DIR/linux"
	link_folder "$DOTFILES_DIR/linux/config" "*" "$HOME/.config"
elif [ "$(uname)" == "Darwin" ]; then
	link_folder "$DOTFILES_DIR/macos"
	link_folder "$DOTFILES_DIR/macos/config" "*" "$HOME/.config"
fi

[ ! -d "$HOME/.ssh" ] && mkdir "$HOME/.ssh"
chmod 600 "$DOTFILES_DIR/ssh/config" # Fix for permissions issue
link "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"

# ~/.config/git/config has general git aliases and settings
# ~/.gitconfig is not symlinked. This file will hold user settings
touch "$HOME/.gitconfig"
