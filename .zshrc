# Basic zsh configuration

export ZSH=$HOME/.config/zsh
export ZSH_THEME=bnj

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.exports" ] && source "$HOME/.exports"
[ -f "$HOME/.macos_aliases" ] && source "$HOME/.macos_aliases"

for file in $HOME/.config/zsh/*.zsh; do
	source "$file"
done
