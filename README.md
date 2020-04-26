# benji's dotfiles

## Changelog
### 04-2020
* Generalizing things to be used between multiple systems
* Add [links](local/bin/links) to link dotfiles
* Add corresponding `*.links` files for all my setups

---

## Setup
To only setup dotfiles, run the [links](local/bin/links) with the appropriate
`*.links` file.

```
./local/bin/links -f void.links
```

---

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
