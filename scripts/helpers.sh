#!/usr/bin/env bash
# Modified from https://github.com/atomantic/dotfiles

now=$(date +"%Y.%m.%d.%H.%M.%S")
BACKUP_DIR="$HOME/.dotfiles_backup/$now"

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"0m"
COL_RED=$ESC_SEQ"31m"
COL_GREEN=$ESC_SEQ"32m"
COL_YELLOW=$ESC_SEQ"33m"
COL_BLUE=$ESC_SEQ"34m"
COL_MAGENTA=$ESC_SEQ"35m"
COL_CYAN=$ESC_SEQ"36m"

info() {
	printf "${COL_RESET}[${COL_YELLOW}INFO${COL_RESET}] $1\n"
}

running() {
	printf "${COL_RESET}${COL_CYAN}  ⇒${COL_RESET}    $1..."
}

success() {
	if [ $# -eq 0 ]; then
		printf "${COL_GREEN}  OK${COL_RESET}\n"
	else
		printf "${COL_RESET}${COL_GREEN}  OK${COL_RESET}   $1\n"
	fi
}

warn() {
	printf "${COL_YELLOW}$1${COL_RESET}\n"
}

fail() {
	printf "${COL_RED}FAIL${COL_RESET}\n"
	if [ $# -eq 1 ]; then
		printf "${COL_RESET}${COL_RED}⇒${COL_RESET}      $1\n"
	fi
}

link() {
	filename="${1##*/}"
	if [[ -e "$2" && ! -L "$2" ]]; then
		mkdir -p "$BACKUP_DIR"
		mv $2 "$BACKUP_DIR/$filename"
		info "$filename backed up"
	fi

	unlink "$2" > /dev/null 2>&1
	
	running "linking $filename"
	ln -sfn "$1" "$2" > /dev/null 2>&1
	success
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
