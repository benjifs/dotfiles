#!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
# @author Adam Eivy (github.com/atomantic)
# Edited by benjifs 01/06/2020
###########################

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SCRIPTS="$DOTFILES_DIR/scripts"

# Includes helpers
source "$SCRIPTS/helpers.sh"

info "Starting dotfiles setup..."

# Setup for macOS
if [ "$(uname -s)" == "Darwin" ]; then
	info "Running macOS scripts"
	. "$SCRIPTS/prep.sh"
	. "$SCRIPTS/brew.sh"
	. "$SCRIPTS/macos.sh"
	. "$SCRIPTS/map-caps-to-ctrl.sh"

	success "Completed macOS scripts"
fi

. "$SCRIPTS/links.sh"
. "$SCRIPTS/postdots.sh"

success "setup complete"
