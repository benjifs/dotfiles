#!/usr/bin/env bash
# Helper script to sync local files with remote
# example:
#           deploy.sh . VPS:/path/to/directory/.

help() {
	echo "do something here"
}

invalid() {
	echo ".dply does not exist"
	echo "deploy.sh init"
	exit 1
}

init() {
	if [ ! -f .dply ]; then
		echo "declare -a DPLY_PARAMS=(" > .dply
		echo "  LOCAL_SITE" >> .dply
		echo "  REMOTE_SITE" >> .dply
		echo ")" >> .dply
	else
		echo ".dply already exists"
		exit 1
	fi
}

deploy() {
	rsync -avH --exclude={'.*','node_modules','src'} $1 -e ssh $2
}

if [ $# -eq 1 ] && [ $1 == "init" ]; then
	init
	exit
elif [ ! -f .dply ] && [ $# -ne 2 ]; then
	invalid
	exit 1
fi

if [ $# -eq 2 ]; then
	deploy $1 $2
else
	source $(pwd)/.dply
	if [ -v DPLY_PARAMS ]; then
		deploy ${DPLY_PARAMS[0]} ${DPLY_PARAMS[1]}
	else
		invalid
	fi
fi

