# initialize autocomplete
autoload -Uz compinit

# Speed up zsh compinit
# https://carlosbecker.com/posts/speeding-up-zsh
# Switched to prezto's implementation of zcompdump to work everywhere
# https://github.com/sorin-ionescu/prezto
_comp_files=(${ZCACHE:-$HOME}/zcompdump)
if (( $#_comp_files )); then
	compinit -i -C -d ${ZCACHE:-$HOME}/zcompdump
else
	compinit -i -d ${ZCACHE:-$HOME}/zcompdump
fi
unset _comp_files

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZCACHE

zstyle ':completion:*' menu select # Highlight current selection
zstyle ':completion:*' completer _complete _expand
zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

setopt menu_complete # automatically select the first completion match
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
