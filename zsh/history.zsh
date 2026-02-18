HISTSIZE=10000                      # How many lines of history to keep in memory
SAVEHIST=50000                      # Number of history entries to save to disk
HISTFILE=$ZCACHE/zsh_history        # Where to save history to disk
HISTDUP=erase                       # Erase duplicates in the history file

# Source: https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh
# History command configuration
setopt extended_history             # record timestamp of command in HISTFILE
setopt hist_expire_dups_first       # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups             # ignore duplicated commands history list
setopt hist_ignore_space            # ignore commands that start with space
setopt hist_verify                  # show command with history expansion to user before running it
setopt inc_append_history           # add commands to HISTFILE in order of execution
setopt share_history                # share command history data
