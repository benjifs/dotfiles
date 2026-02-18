ZLE_RPROMPT_INDENT=0

setopt prompt_subst

PROMPT="%F{8}[%F{4}%1~%F{8}]%F{3}
%(!.#.❯)%f "

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%F{4}⚡︎%F{2}%b%f%a%m'
zstyle ':vcs_info:*' formats '%F{2}%b%f%a%m'
zstyle ':vcs_info:git+set-message:*' hooks git-status

+vi-git-status() {
	# Exit if not a git repo
	git rev-parse --abbrev-ref @{upstream} &>/dev/null || return

	local ahead behind
	read ahead behind < <(
		git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null
	)
	(( ahead > 0 ))  && hook_com[misc]+="%F{3}↑${ahead}"
	(( behind > 0 )) && hook_com[misc]+="%F{1}↓${behind}"

  local GIT_STATUS=$(git status --porcelain)
  # local STAGED=$(echo $GIT_STATUS | grep -v '??' | grep -v '^ ' | grep -v '^$' | wc -l | tr -d ' ')
  # (( STAGED > 0 )) && hook_com[misc]+="%F{3}+${STAGED}"

  local UNSTAGED=$(echo $GIT_STATUS | grep -v '??' | grep '^ ' | wc -l | tr -d ' ')
  # (( UNSTAGED > 0 )) && hook_com[misc]+="%F{1}!${UNSTAGED}"

  # local UNTRACKED=$(echo $GIT_STATUS | grep '??' | wc -l | tr -d ' ')
  # (( UNTRACKED > 0 )) && hook_com[misc]+="%F{1}?${UNTRACKED}"

	if [[ -n $hook_com[misc] || $UNSTAGED > 0 ]]; then
		hook_com[misc]+="%F{1}✗"
	else
		hook_com[misc]+="%F{2}✓"
	fi
}

precmd() {
	vcs_info
	prompt_extra=""
	[[ -n $vcs_info_msg_0_ ]] && prompt_extra+="$vcs_info_msg_0_"
	[[ -n $SSH_CONNECTION ]] && prompt_extra+="%F{8}${prompt_extra:+|}%F{5}%n%F{3}@%F{6}%m%F{8}%f"
	[[ -n $prompt_extra ]] && prompt_extra="%F{8}[$prompt_extra%F{8}]%f"
}

RPROMPT='$prompt_extra'
