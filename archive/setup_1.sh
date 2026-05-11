#!/bin/bash

cd "$( cd "$( dirname "$0"  )" && pwd  )" || exit 1

sudo echo &>/dev/null || (error 'failed to obtain root permissions'; exit 1)

# Update mirrorlist with the fastest mirrors
sudo pacman-mirrors --fasttrack
sudo pacman -Syyu

git config --global init.defaultBranch main

sudo pacman -S --noconfirm --needed base-devel rustup
rustup default stable

# Install paru
git clone https://aur.archlinux.org/paru.git || exit 1
cd paru || exit 1
makepkg -si || exit 1
cd .. || exit 1
rm -rf paru

# Install fish shell
sudo pacman -S --noconfirm --needed fish
chsh -s $(which fish)

# FIXME: can only be execute under fish shell enviroment
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
# Warning: Human intervention required
# fisher install IlanCosman/tide@v6
# tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Many icons' --transient=Yes

# Install flatpak apps
flatpak_apps=(
    # utilities
    com.github.tchx84.Flatseal
    org.bleachbit.BleachBit

    # browsers
    com.microsoft.Edge
    org.torproject.torbrowser-launcher

    # security
    com.bitwarden.desktop
    org.kde.kleopatra
    org.keepassxc.KeePassXC

    # communication
    com.qq.QQ
    com.tencent.WeChat
    org.telegram.desktop

    # development
    org.wezfurlong.wezterm
    com.visualstudio.code
    dev.zed.Zed
    re.rizin.cutter

    # multimedia
    com.qq.QQmusic

    # office
    org.mozilla.Thunderbird
    org.libreoffice.LibreOffice
    com.github.IsmaelMartinez.teams_for_linux
)
for app in "${flatpak_apps[@]}"; do
    flatpak install -y "$app"
done

# Install input method (fcitx5 + rime)
sudo pacman -S --noconfirm --needed fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime || exit 1
# Warning: This step may take a long time
sudo pacman -S --noconfirm --needed rime-ice-git || exit 1 # 雾凇拼音

# Install command line utilities
sudo pacman -S --noconfirm --needed eza bat lazygit git-delta neovide

# Install font
sudo pacman -S --noconfirm --needed otf-cascadia-code

sudo pacman -S --noconfirm --needed nodejs

paru -S --noconfirm --needed amber-bash-bin
