#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include helpers
source "$DOTFILES_DIR/scripts/helpers.sh"

running "checking sudo state"
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `brew.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

success

running "checking homebrew install"
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
	success
	running "installing homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	if [[ $? != 0 ]]; then
		error "unable to install homebrew, script $0 abort!"
		exit -1
  fi
else
	warn "ALREADY INSTALLED"

	# Update homebrew
	running "updating homebrew"
	brew update
	success

	info "before installing brew packages, we can upgrade any outdated packages."
	read -r -p "run brew upgrade? [y|N] " response
	if [[ $response =~ ^(y|yes|Y) ]]; then
		# Upgrade any already-installed formulae
		running "upgrade brew packages..."
		brew upgrade
		success
	fi
fi
success "Homebrew initial setup complete"

info "Running brew bundle"
brew bundle $DOTFILES_DIR/macos

success "Homebrew apps installed"

brew cleanup > /dev/null 2>&1
success "Homebrew all clean"
