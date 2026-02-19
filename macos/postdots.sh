#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include helpers
source "$SCRIPTS/helpers.sh"

info "checking default shell"
if [ "$(uname -s)" == "Darwin" ]; then
	running "setting zsh as default shell"
	CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
	if [[ "$CURRENTSHELL" != "/bin/zsh" ]]; then
		# sudo bash -c 'echo "/bin/zsh" >> /etc/shells'
		# chsh -s /usr/local/bin/zsh
		sudo dscl . -change /Users/$USER UserShell $SHELL /bin/zsh > /dev/null 2>&1
		success
	else
		warn "ZSH IS DEFAULT SHELL"
	fi
fi

read -r -p "Would you like to setup your git config? [y/N] " response
if [[ $response =~ ^(y|yes|Y) ]]; then
	read -r -p "Enter your name: " name
	read -r -p "Enter your git email: " email
	git config --global user.name "$name"
	git config --global user.email "$email"
	success
else
	info "Skipped git setup"
fi

read -r -p "Would you like to run yabai and skhd on startup? [y/N] " response
if [[ $response =~ ^(y|yes|Y) ]]; then
	yabai --start-service
	skhd --start-service
	success
else
	info "Skipped yabai/skhd setup"
fi

read -r -p "Would you like to run 'slink' to link your dotfiles [y/N] " response
if [[ $response =~ ^(y|yes|Y) ]]; then
	mkdir -p ${GNUPGHOME:-$HOME/.config/gnupg}
	chmod 700 ${GNUPGHOME:-$HOME/.config/gnupg}
	gpgconf --kill gpg-agent
	gpgconf --launch gpg-agent
	$SCRIPTS/../bin/slink -f $SCRIPTS/../macos.links
	success "All dotfiles have been linked"
else
	info "Skipped slink setup"
fi
