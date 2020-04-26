#!/usr/bin/env bash
# Modified from https://github.com/atomantic/dotfiles

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
	printf "${COL_RESET}${COL_CYAN}  ⇒${COL_RESET}    $1... "
}

success() {
	if [ $# -eq 0 ]; then
		printf "${COL_GREEN}  OK${COL_RESET}\n"
	else
		printf "${COL_RESET}${COL_GREEN}  OK${COL_RESET}   $1\n"
	fi
}

warn() {
	printf " ${COL_YELLOW}$1${COL_RESET}\n"
}

fail() {
	printf "${COL_RED}FAIL${COL_RESET}\n"
	if [ $# -eq 1 ]; then
		printf "${COL_RESET}${COL_RED}  ⇒${COL_RESET}    $1\n"
	fi
}
