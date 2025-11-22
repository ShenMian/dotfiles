#!/bin/bash

cd "$( cd "$( dirname "$0"  )" && pwd  )" || exit

sudo echo &>/dev/null || (error 'Failed to get sudo permission.'; exit 1)

sudo pacman-mirrors -c China
sudo pacman -Syyu
sudo pacman -S --needed --noconfirm yay make || exit 1

# neofetch
echo "Setup neofetch"
yay -S --needed --noconfirm neofetch || exit 1
neofetch

# clash (proxy)
echo "Setup clash"
yay -S --needed --noconfirm clash || exit 1
mkdir ~/.config/clash

unset HTTP_PROXY
unset HTTPS_PROXY
unset http_proxy
unset https_proxy
echo "Download 'Country.mmdb'"
curl -L -C - "https://cdn.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/Country.mmdb" -o ~/.config/clash/Country.mmdb || exit 1

read -p "Press any key to resume ..."

echo "Launch clash"
killall clash
systemctl --user enable clash --now
sleep 3

export http_proxy='http://127.0.0.1:7897/'
export https_proxy='http://127.0.0.1:7897/'

# git
echo "Setup git"
git config --global core.editor 'nvim'
git config --global http.proxy 'http://127.0.0.1:7897'
git config --global https.proxy 'http://127.0.0.1:7897'

# font
echo "Setup font"
sudo pacman -S otf-cascadia-code

# neovim (editor)
echo "Setup neovim"
yay -S --needed --noconfirm neovim python-pynvim || exit 1
yay -S --needed --noconfirm ripgrep || exit 1
yay -S --needed --noconfirm neovide || exit 1

# Fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v6

# fcitx5 (input method)
yay -S --needed --noconfirm fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime || exit 1

sudo sh -c """
{
	echo ''
	echo 'export GTK_IM_MODULE=fcitx';
	echo 'export QT_IM_MODULE=fcitx';
	echo 'export SDL_IM_MODULE=fcitx';
	echo 'XMODIFIERS="@im=fcitx"';
} >> "/etc/profile"
"""

# fcitx5-rime Windows 10 like skins
git clone https://github.com/thep0y/fcitx5-themes-candlelight /tmp/fcitx5-themes || exit 1
mkdir -p ~/.local/share/fcitx5/themes
cp -r /tmp/fcitx5-themes/spring ~/.local/share/fcitx5/themes
cp -r /tmp/fcitx5-themes/winter ~/.local/share/fcitx5/themes
cp -r /tmp/fcitx5-themes/autumn ~/.local/share/fcitx5/themes
cp -r /tmp/fcitx5-themes/summer ~/.local/share/fcitx5/themes
rm -rf /tmp/fcitx5-themes

mkdir -p ~/.config/fcitx5/conf
{
	echo '# 字体';
	echo 'Font="Smartisan Compact CNS 13"';
	echo '# 主题';
	echo 'Theme=spring';
	echo '# 按屏幕 DPI 使用';
	echo 'PerScreenDPI=True';
} >> "$HOME/.config/fcitx5/conf/classicui.conf"

# 启用候选字符单行显示
# {
# 	echo '# 垂直候选列表'
# 	echo 'Vertical Candidate List=False'
# } >> "$HOME/.config/fcitx5/conf/classicui.conf"
# echo 'PreeditInApplication=True' >> "$HOME/.config/fcitx5/conf/rime.conf"

# github-cli
yay -S --needed --noconfirm github-cli || exit 1
gh auth login
gh auth setup-git

# razer drivers
yay -S --needed --noconfirm openrazer-meta polychromatic linux61-headers
sudo modprobe razerkbd
sudo gpasswd -a $USER plugdev

# lazygit
yay -S --needed --noconfirm lazygit git-delta || exit 1
{
	echo "[core]"
	echo "    pager = delta"
	echo ""
	echo "[interactive]"
	echo "    diffFilter = delta --color-only"
	echo ""
	echo "[delta]"
	echo "    navigate = true    # use n and N to move between diff sections"
	echo "    light = false      # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)"
	echo ""
	echo "[merge]"
	echo "    conflictstyle = diff3"
	echo ""
	echo "[diff]"
	echo "    colorMoved = default"
} >> "$HOME/.gitconfig"

###

# 命令行
yay -S --needed --noconfirm eza bat zoxide fd btop || exit 1

# 浏览器
flatpak install com.microsoft.Edge

# 娱乐软件
flatpak install com.qq.QQmusic
flatpak install com.valvesoftware.Steam

# 社交软件
flatpak install org.telegram.desktop
flatpak install com.qq.QQ
flatpak install com.tencent.WeChat

# 办公软件
flatpak install org.libreoffice.LibreOffice

flatpak install com.bitwarden.desktop

###

# 卸载 Manjaro 自带的软件
yay -Rns --noconfirm firefox
# yay -Rns vi gnome-terminal gedit gthumb

./update.sh

read -p "Press any key to reboot ..."

reboot

# tmux (terminal multiplexer)
# yay -S --needed --noconfirm tmux || exit 1
# git clone https://github.com/gpakosz/.tmux.git ~/.config/tmux || exit 1
# ln -s -f ~/.config/tmux/.tmux.conf ~/.tmux.conf
# cp ~/.config/tmux/.tmux.conf.local ~/.tmux.conf.local

# lf (terminal file manager)
# yay -S --needed --noconfirm lf, trash-cli || exit 1

# kitty (terminal)
# yay -S --needed --noconfirm kitty

# neomutt
# yay -S --needed --noconfirm neomutt || exit 1
# yay -S --needed mutt-wizard|| exit 1

# zsh (shell)
# yay -S --needed --noconfirm zsh-theme-powerlevel10k || exit 1
# p10k configure
# yay -S zsh-vi-mode

