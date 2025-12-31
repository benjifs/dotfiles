autoload -Uz compinit

compinit -d $ZCACHE/zcompdump

# Is this necessary?
# Speed up zsh compinit
# https://carlosbecker.com/posts/speeding-up-zsh
# Switched to prezto's implementation of zcompdump to work everywhere
# https://github.com/sorin-ionescu/prezto
# _comp_files=(${ZCACHE:-$HOME}/zcompdump)
# if (( $#_comp_files )); then
# 	compinit -i -C -d ${ZCACHE:-$HOME}/zcompdump
# else
# 	compinit -i -d ${ZCACHE:-$HOME}/zcompdump
# fi
# unset _comp_files

setopt menu_complete       # automatically select the first completion match
setopt auto_list           # automatically list choices on ambiguous completion
setopt auto_menu           # automatically use menu completion
setopt always_to_end       # move cursor to end if word had one match

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# approx match
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZCACHE
