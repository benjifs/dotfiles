# benji's dotfiles

Moving things here for now. Trying out a new setup

## Docker
This might not be the best way to do this but its a nice quick way to test out the basic dotfiles.
```bash
docker build -t benjifs/dots .
docker run -it --rm benjifs/dots
```

## git --bare (unused)
Saving this because its a different way to setup the dotfiles in a new system. In the end, I still prefer symlinking everything. 
```bash
git clone --bare git@github.com:benjifs/dotfiles.git $HOME/.dotfiles
echo 'alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"' >> $HOME/.zshrc
dots config --local status.showUntrackedFile no
dots checkout
```
