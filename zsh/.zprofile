# Disable .zsh_sessions
# https://superuser.com/a/1610999
export SHELL_SESSIONS_DISABLE=1

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

# Set workspace
export WORKSPACE=$HOME/workspace

# Make nvim the default editor.
export EDITOR=nvim

# Prefer US English and use UTF-8.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X'

if [ "$(uname -s)" = "Darwin" ]; then
	if [ "$(uname -m)" = "arm64" ]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	else
		eval "$(/usr/local/bin/brew shellenv)"
	fi
fi

export PATH=$XDG_BIN_HOME:$PATH
