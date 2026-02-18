# Remove RPROMPT padding-right
ZLE_RPROMPT_INDENT=0

setopt prompt_subst
autoload -U colors && colors

# colors
BNJ_RESET_COLOR="%{$reset_color%}"
BNJ_SEPARATOR_COLOR="%F{003}"
BNJ_PROMPT_COLOR="%F{003}"
BNJ_USERNAME_COLOR="%F{005}"
BNJ_HOSTNAME_COLOR="%F{006}"
BNJ_DIR_COLOR="%F{004}"
BNJ_GIT_BRANCH="%F{002}"
BNJ_GIT_CLEAN_COLOR="%F{002}"
BNJ_GIT_DIRTY_COLOR="%F{001}"
BNJ_GIT_WARNING_COLOR="%F{003}"
BNJ_GIT_MERGE_COLOR="%F{004}"
BNJ_LINE_COLOR="%F{008}"
BNJ_TEXT_COLOR="%F{015}"

GIT_PROMPT_AHEAD="$BNJ_GIT_WARNING_COLOR⇡"
GIT_PROMPT_BEHIND="$BNJ_GIT_DIRTY_COLOR⇣"
GIT_PROMPT_ALERT="$BNJ_GIT_DIRTY_COLOR●"
GIT_PROMPT_CLEAN="$BNJ_GIT_CLEAN_COLOR✓"
GIT_PROMPT_DIRTY="$BNJ_GIT_DIRTY_COLOR✗"
GIT_PROMPT_STAGED="$BNJ_GIT_CLEAN_COLOR●"
GIT_PROMPT_UNSTAGED="$BNJ_GIT_WARNING_COLOR●"
GIT_PROMPT_MERGE="$BNJ_GIT_MERGE_COLOR⚡︎"

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "$BNJ_GIT_BRANCH%b%m"
zstyle ':vcs_info:*' actionformats "$BNJ_GIT_BRANCH%b%m"
zstyle ':vcs_info:git*+set-message:*' hooks git-status

precmd() {
	vcs_info
}

# Is this overkill?
# vcs_info doesn't show untracked alert
# references:
# https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html
# https://github.com/jonathanjsimon/S1cK94-minimal/blob/master/minimal.zsh-theme
+vi-git-status() {
	# Exit if not a git repo
	! $(git rev-parse --is-inside-work-tree 2> /dev/null) && return

	local out=""
	local rs="$(git status --porcelain -b)"

	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
		out+="$GIT_PROMPT_MERGE"
	fi

	local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_BEHIND" -gt 0 ]; then
		out+="$GIT_PROMPT_BEHIND$NUM_BEHIND"
	fi
	local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_AHEAD" -gt 0 ]; then
		out+="$GIT_PROMPT_AHEAD$NUM_AHEAD"
	fi

	# local NUM_UNTRACKED="$(echo "$rs" | grep '^??.*' | wc -l | tr -d ' ')"
	# if [ "$NUM_UNTRACKED" -gt 0 ]; then
	# 	out+="$GIT_PROMPT_ALERT"
	# fi
	# local NUM_UNSTAGED="$(echo "$rs" | grep '^AM.*' | wc -l | tr -d ' ')"
	# if [ "$NUM_UNSTAGED" -gt 0 ]; then
	# 	out+="$GIT_PROMPT_UNSTAGED"
	# fi
	# local NUM_STAGED="$(echo "$rs" | grep '^A .*' | wc -l | tr -d ' ')"
	# if [ "$NUM_STAGED" -gt 0 ]; then
	# 	out+="$GIT_PROMPT_STAGED"
	# fi

	if $(echo "$rs" | grep -v '^##' &> /dev/null); then #dirty
		out+="$GIT_PROMPT_DIRTY"
	fi
	if [ -z $out ]; then
		out+="$GIT_PROMPT_CLEAN"
	fi

	hook_com[misc]="$out"
}

PROMPT='\
$BNJ_LINE_COLOR┌[\
$BNJ_USERNAME_COLOR%n\
$BNJ_SEPARATOR_COLOR@\
$BNJ_HOSTNAME_COLOR%m\
$BNJ_LINE_COLOR]─[\
$BNJ_DIR_COLOR%0~\
$BNJ_LINE_COLOR]
$BNJ_LINE_COLOR└─ \
$BNJ_PROMPT_COLOR%(!.#.%%)$BNJ_TEXT_COLOR$BNJ_RESET_COLOR '

RPROMPT='${vcs_info_msg_0_}$BNJ_RESET_COLOR'
