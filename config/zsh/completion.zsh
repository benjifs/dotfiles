
# initialize autocomplete
autoload -Uz compinit

# Speed up zsh compinit
# https://carlosbecker.com/posts/speeding-up-zsh
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
	compinit
else
	compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _approximate _expand
zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

setopt menu_complete
