#!/usr/bin/env bash

export DOTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

link() {
	filename="${1##*/}"

	echo "linking ${filename} -> ${2}"
	ln -sfn "$1" "$2" > /dev/null 2>&1
}

link_folder() {
	[ ! -d "$1" ] && return

	MATCH=${2:-".*"}
	DEST=${3:-$HOME}
	find "$1" -maxdepth 1 -mindepth 1 -name "$MATCH" | while read file; do
		filename="${file##*/}"

		if [[ "$file" == "." || "$file" == ".." || "$filename" == ".git" ]]; then
			continue
		fi
		
		link "$file" "$DEST/$filename"
	done
}

link_folder "$DOTS"
[ ! -d "$HOME/.config" ] && mkdir "$HOME/.config"
link_folder "$DOTS/config" "*" "$HOME/.config"

if [[ "$PREFIX" = "com.termux" ]]; then
	# Might need a more reliable way of checking for termux.
	# This works for now
	link_folder "$DOTS/android"
elif [ "$(uname)" == "Linux" ]; then
	link_folder "$DOTS/linux"
	link_folder "$DOTS/linux/config" "*" "$HOME/.config"
elif [ "$(uname)" == "Darwin" ]; then
	link_folder "$DOTS/macos"
	link_folder "$DOTS/macos/config" "*" "$HOME/.config"
fi

# ~/.config/git/config has general git aliases and settings
# ~/.gitconfig is not symlinked. This file will hold user settings
touch "$HOME/.gitconfig"
