
FROM archlinux/base:latest

RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm curl git vim tmux zsh

ADD . /dotfiles
WORKDIR /dotfiles

RUN ["/usr/bin/bash", "-c", "source scripts/links.sh"]
CMD ["/usr/bin/zsh", "-l"]
