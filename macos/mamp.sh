#!/usr/bin/env bash
# references:
# 	https://gist.github.com/plcosta/6b69a2a954bbe82ca3db4681fad1003c
# 	https://mallinson.ca/posts/5/the-perfect-web-development-environment-for-your-new-mac

# Get current dir (so run this script from anywhere)
export SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include helpers
source "$SCRIPTS/helpers.sh"

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

BREW="$(brew --prefix)"

# dnsmasq
info "Installing and setting up dnsmasq"
brew install dnsmasq
DNSMASQ="$(brew --prefix dnsmasq)"

[[ ! -d "$BREW/etc" ]] && mkdir -p "$BREW/etc"
echo 'address=/.test/127.0.0.1' > "$BREW/etc/dnsmasq.conf"

sudo brew services start dnsmasq

[[ ! -d "/etc/resolver" ]] && sudo mkdir "/etc/resolver"
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'

success "Finished dnsmasq setup"

# MySQL
info "Install MySQL"
brew install mysql
brew services start mysql
success "MySQL installed"

# PHP
info "Install PHP@8.3"
brew tap shivammathur/php
brew install shivammathur/php/php@8.3
brew unlink php
brew link — overwrite — force php@8.3
success "PHP@8.3 installed"

# Apache
info "Setup Apache"

info "Stop apachectl"
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

info "Install httpd"
brew install httpd
HTTPD="$BREW/etc/httpd/httpd.conf"

[[ -e "$HTTPD" ]] && cp "$HTTPD" "$HTTPD.backup"

if [[ -e "$HTTPD" ]]; then
	sed -i '' 's/Listen 8080/Listen 80/g' "$HTTPD"
	sed -i '' "s|\"/usr/local/var/www\"|\"${WORKSPACE}\"|g" "$HTTPD"
	sed -i '' 's/AllowOverride None/AllowOverride All/g' "$HTTPD"
	sed -i '' '/mod_rewrite/s/^#//g' "$HTTPD"
	sed -i '' "s|User _www|User $(whoami)|g" "$HTTPD"
	sed -i '' "s|Group _www|Group $(id -gn)|g" "$HTTPD"
	if ! grep -wq "ServerName localhost" "$HTTPD"; then
		sed -i '' '/#ServerName/s/$/\nServerName localhost/g' "$HTTPD"
	fi
	if ! grep -wq "php_module" "$HTTPD"; then
		NUMBER=`awk '/^LoadModule/{n=NR}END{print n}' $HTTPD`
		sed -i '' -e "${NUMBER}s|$|\nLoadModule php_module $(brew --prefix php)/lib/httpd/modules/libphp.so|" "$HTTPD"
	fi
	sed -i '' 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/g' "$HTTPD"
	sed -i '' '/mod_deflate/s/^#//g' "$HTTPD"
	sed -i '' '/mod_vhost_alias/s/^#//g' "$HTTPD"
	sed -i '' '/httpd-vhosts.conf/s/^#//g' "$HTTPD"
fi

info "Setup virtual hosts"
VHOSTS="$BREW/etc/httpd/extra/httpd-vhosts.conf"
[[ -e "$VHOSTS" ]] && mv "$VHOSTS" "$VHOSTS.backup"

cp "$SCRIPTS/httpd-vhosts.conf" "$VHOSTS"
sed -i '' "s|{WORKSPACE}|${WORKSPACE}|g" "$VHOSTS"

brew services start httpd

success "Apache setup complete"

success "MAMP setup complete"
info "Restart might be needed for configs to work correctly"
