#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Includes helpers
source "$DOTFILES_DIR/scripts/helpers.sh"

info "checking default shell"
if [ "$(uname -s)" == "Darwin" ]; then
	CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
	if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
		running "setting newer homebrew zsh (/usr/local/bin/zsh) as your shell (password required)"
		# sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
		# chsh -s /usr/local/bin/zsh
		sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
		success
	else
		info "zsh is already the default shell"
	fi


	read -r -p "Would you like to run the server setup script? [y/N] " ny
	if [[ $ny =~ ^([yY][eE][sS]|[yY])$ ]];then
		. "$DOTFILES_DIR/server.sh"
		success
	else
		info "Skipped server setup"
	fi
fi

read -r -p "Would you like to setup your git config? [y/N] " yn
if [[ $yn =~ ^([yY][eE][sS]|[yY])$ ]];then
	read -r -p "Enter your name: " name
	read -r -p "Enter your git email: " email
	git config --global user.name "$name"
	git config --global user.email "$email"
	success
else
	info "Skipped git setup"
fi
