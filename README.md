# benji's dotfiles

## Changelog

### 2025
* Renamed `links` to [`slink`](/bin/slink)
* Moved to Apple Silicon macOS so changed a few things

### 2022
* Updating to nvim

### 04-2020
* Generalizing things to be used between multiple systems
* Add [`links`](/bin/links) to link dotfiles
* Add corresponding `*.links` files for all my setups
* Move macOS setup stuff to its own directory.

---

## dotfiles setup
To only setup dotfiles, run [`./bin/slink`](/bin/slink) with the appropriate
`*.links` file.

```bash
./bin/slink -f void.links
```

## macOS setup
To automate the macOS setup, use [`run.sh`](macos_setup/run.sh) which should go
through the whole process of updating, installing files from
[Brewfile](macos_setup/Brewfile). Optionally you can also run
[mamp.sh](macos_setup/mamp.sh) to setup local web server for testing so
directories under `~/workspace/` will be accessible from `*.test`. For example:
`~/workspace/site` can be reached from `http://site.test`. Lastly, there is
also an additional script to automatically map CAPS_LOCK to CTRL with
[map-caps-to-ctrl.sh](macos_setup/map-caps-to-ctrl.sh).

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
