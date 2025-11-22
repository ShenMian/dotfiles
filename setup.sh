#!/bin/bash

cd "$(cd "$(dirname "$0")" && pwd)" || exit 1

sudo echo &>/dev/null || (
    error 'failed to obtain root permissions'
    exit 1
)

# Update mirrorlist with the fastest mirrors
sudo pacman-mirrors --fasttrack
sudo pacman -Syyu

# Install `paru` (AUR helper)
# git clone --depth 1 https://aur.archlinux.org/paru.git || exit 1
# cd paru || exit 1
# makepkg -si || exit 1
# cd .. || exit 1
# rm -rf paru

sudo pacman -S --noconfirm --needed base-devel || exit 1

paru -S --noconfirm --needed amber-bash-bin

amber setup.ab
