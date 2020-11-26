FROM archlinux/base:latest

RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm curl git vim tmux zsh

ADD . /dotfiles
WORKDIR /dotfiles

RUN ["/usr/bin/bash", "-c", "mkdir ~/.config"]
RUN ["/usr/bin/bash", "-c", "source local/bin/links -f void.links"]

WORKDIR /root

CMD ["/usr/bin/zsh", "-l"]
