#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include helpers
source "$SCRIPTS/helpers.sh"

info "checking default shell"
if [ "$(uname -s)" == "Darwin" ]; then
	running "setting zsh as default shell"
	CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
	if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
		# sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
		# chsh -s /usr/local/bin/zsh
		sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
		success
	else
		warn "ZSH IS DEFAULT SHELL"
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
