#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include helpers
source "$SCRIPTS/helpers.sh"

exit

running "checking sudo state"
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `prep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

success

# Step 1: Update the OS and Install Xcode Tools
info "Updating OSX.  If this requires a restart, run the script again."
# Install all available updates
sudo softwareupdate -ia --verbose
# Install only recommended available updates
#sudo softwareupdate -ir --verbose
success

info "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install
success

read -r -p "What do you want to name your computer? Press [Enter] key to keep current name. " hostname
if [ "$hostname" != "" ];then
	running "Changing hostname to $COL_YELLOW$hostname$COL_RESET"
	sudo scutil --set ComputerName "$hostname"
	sudo scutil --set LocalHostName "$hostname"
	sudo scutil --set HostName "$hostname"
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$hostname"
	success
else
	info "Hostname will not be changed"
fi
