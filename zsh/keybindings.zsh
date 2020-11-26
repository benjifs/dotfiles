# History search with up/down arrows
# https://github.com/robbyrussell/oh-my-zsh/issues/1720
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey "^R" history-incremental-search-backward

# Clear line with CTRL-U
# Should work out of the box but sometimes
# without this line it doesn't. Keeping for now
bindkey \^u kill-whole-line
