# initialize autocomplete
autoload -Uz compinit

# Speed up zsh compinit
# https://carlosbecker.com/posts/speeding-up-zsh
# Switched to prezto's implementation of zcompdump to work everywhere
# https://github.com/sorin-ionescu/prezto
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
	compinit -i -C
else
	compinit -i
fi
unset _comp_files

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _approximate _expand
zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

setopt menu_complete
# Testing
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

