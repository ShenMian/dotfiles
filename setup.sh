#!/bin/bash

cd "$( cd "$( dirname "$0"  )" && pwd  )" || exit 1

sudo echo &>/dev/null || (error 'failed to obtain root permissions'; exit 1)

# Update mirrorlist with the fastest mirrors
sudo pacman-mirrors --fasttrack
sudo pacman -Syyu

sudo pacman -S --noconfirm --needed rustup || exit 1
rustup default stable || exit 1

# Install paru
git clone https://aur.archlinux.org/paru.git || exit 1
cd paru || exit 1
makepkg -si || exit 1
cd .. || exit 1
rm -rf paru

paru -S --noconfirm --needed amber-bash-bin

amber setup.sh
