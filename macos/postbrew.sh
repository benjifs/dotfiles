#!/usr/bin/env bash
# The following should run after running brew.sh

# Fix yabai Finder animation issue
# https://github.com/koekeishiya/yabai/wiki/Tips-and-tricks#fix-folders-opened-from-desktop-not-tiling
defaults write com.apple.finder DisableAllAnimations -bool true