#!/usr/bin/env bash
# Helper script to sync local files with remote
# example:
#           deploy.sh . VPS:/path/to/directory/.

usage() {
	echo "Options:"
	echo "    deploy.sh init"
	echo "    deploy.sh /local/dir REMOTE:/remote/dir"
	exit 1
}

invalid() {
	echo -e "ERROR: $1\n"
	usage
}

init() {
	if [ ! -f .dply ]; then
		echo "declare -a DPLY_PARAMS=(" > .dply
		echo "  LOCAL_SITE" >> .dply
		echo "  REMOTE_SITE" >> .dply
		echo ")" >> .dply
		echo ".dply file created successfully"
		echo "Edit values for LOCAL_SITE and REMOTE_SITE"
	else
		echo ".dply already exists"
	fi
	exit 1
}

deploy() {
	# Don't add spaces after the commas in the `exclude` or curly brace expansion could fail
	rsync -avH --include '.htaccess' --exclude={'.*','node_modules','src','package*.json'} $1 -e ssh $2
}

if [ $# -eq 1 ] && [ $1 == "init" ]; then
	init
elif [ ! -f .dply ] && [ $# -ne 2 ]; then
	invalid ".dply does not exist"
fi

if [ $# -eq 2 ]; then
	deploy $1 $2
else
	source $(pwd)/.dply
	if [ -z "$DPLY_PARAMS" ]; then
		usage
	elif [ "${DPLY_PARAMS[0]}" == "LOCAL_SITE" ] || [ "${DPLY_PARAMS[1]}" == "REMOTE_SITE" ]; then
		invalid ".dply params not set"
	else
		deploy ${DPLY_PARAMS[0]} ${DPLY_PARAMS[1]}
	fi
fi
