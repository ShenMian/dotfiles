#!/bin/bash

cd "$(cd "$(dirname "$0")" && pwd)" || exit 1

sudo echo &>/dev/null || (
    error 'failed to obtain root permissions'
    exit 1
)

# Update mirrorlist with the fastest mirrors
sudo pacman-mirrors --fasttrack
sudo pacman -Syyu

sudo pacman -S --noconfirm --needed base-devel yay || exit 1
yay -S --noconfirm --needed amber-bash-bin

amber setup.ab
