#!/usr/bin/env bash
# references:
# 	https://gist.github.com/plcosta/6b69a2a954bbe82ca3db4681fad1003c
# 	https://mallinson.ca/posts/5/the-perfect-web-development-environment-for-your-new-mac

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include helpers
source "$DOTFILES_DIR/helpers.sh"

info "Development server setup"

# Check if homebrew is installed and exit otherwise
running "checking homebrew install"
command -v brew >/dev/null 2>&1 || { fail "brew not installed. Please install and try again"; exit 1; }
success

info "checking sudo state..."
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

success

info "Installing and setting up dnsmasq"
brew install dnsmasq

BREW="$(brew --prefix)"
DNSMASQ="$(brew --prefix dnsmasq)"

[[ ! -d "$BREW/etc" ]] && mkdir "$BREW/etc"
echo 'address=/.test/127.0.0.1' > "$BREW/etc/dnsmasq.conf"

sudo brew services start dnsmasq

[[ ! -d "/etc/resolver" ]] && sudo mkdir "/etc/resolver"
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'

success "Finished dnsmasq setup"

# Apache
info "Setup Apache"
HTTPD="/private/etc/apache2/httpd.conf"

[[ -e "$HTTPD" ]] && sudo cp "$HTTPD" "$HTTPD.backup"

if [[ -e "$HTTPD" ]]; then
	sudo sed -i '' '/php[0-9]_module/s/^#//g' "$HTTPD"
	sudo sed -i '' '/mod_vhost_alias/s/^#//g' "$HTTPD"
	sudo sed -i '' '/httpd-vhosts.conf/s/^#//g' "$HTTPD"
	sudo sed -i '' '/mod_rewrite/s/^#//g' "$HTTPD"
fi

NUMBER=`awk '/AllowOverride\ none/{ print NR; exit }' $HTTPD`
END=$((NUMBER+1))
sudo sed -i '' -e "${NUMBER},${END}s/^/#/" "$HTTPD"

info "Setup virtual hosts"
VHOSTS="/private/etc/apache2/extra/httpd-vhosts.conf"
[[ -e "$VHOSTS" ]] && sudo mv "$VHOSTS" "$VHOSTS.backup"

sudo cp "$DOTFILES_DIR/httpd-vhosts.conf" "$VHOSTS"
sudo sed -i '' "s|{WORKSPACE}|${WORKSPACE}|g" "$VHOSTS"

sudo apachectl start

success "Apache setup complete"
