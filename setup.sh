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

export http_proxy='http://127.0.0.1:7890/'
export https_proxy='http://127.0.0.1:7890/'

# git
echo "Setup git"
git config --global core.editor 'nvim'
git config --global http.proxy 'http://127.0.0.1:7890'
git config --global https.proxy 'http://127.0.0.1:7890'

# font
echo "Download font"
curl -L -C - "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/CascadiaCode.zip" -o ~/CascadiaCode.zip || exit 1

# neovim (editor)
echo "Setup neovim"
yay -S --needed --noconfirm neovim python-pynvim || exit 1
yay -S --needed --noconfirm ripgrep || exit 1
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim || exit 1
nvim  --headless -c 'autocmd User PackerComplete quitall'
mkdir -p ~/.config/nvim/lua/user
yay -S --needed --noconfirm neovide || exit 1

# microsoft-edge (web browser)
yay -S --needed microsoft-edge-beta-bin || exit 1

# zsh (shell)
yay -S --needed --noconfirm zsh-theme-powerlevel10k || exit 1
p10k configure
yay -S zsh-vi-mode

# tmux (terminal multiplexer)
yay -S --needed --noconfirm tmux || exit 1
git clone https://github.com/gpakosz/.tmux.git ~/.config/tmux || exit 1
ln -s -f ~/.config/tmux/.tmux.conf ~/.tmux.conf
cp ~/.config/tmux/.tmux.conf.local ~/.tmux.conf.local

# lf (terminal file manager)
yay -S --needed --noconfirm lf, trash-cli || exit 1

# kitty (terminal)
# yay -S --needed --noconfirm kitty

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

# fcitx5 skins
git clone https://github.com/thep0y/fcitx5-themes /tmp/fcitx5-themes || exit 1
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
{
	echo '# 垂直候选列表'
	echo 'Vertical Candidate List=False'
} >> "$HOME/.config/fcitx5/conf/classicui.conf"
echo 'PreeditInApplication=True' >> "$HOME/.config/fcitx5/conf/rime.conf"

# github-cli
yay -S --needed --noconfirm github-cli || exit 1
# gh auth login
gh auth setup-git

# power managment
yay -S --needed --noconfirm tlp tlpui powertop || exit 1
sudo systemctl enable tlp --now

# neomutt
yay -S --needed --noconfirm neomutt || exit 1
yay -S --needed mutt-wizard|| exit 1

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

yay -S --needed --noconfirm exa bat zoxide fd tldr ncdu btop the_silver_searcher || exit 1
yay -S --needed --noconfirm element-desktop telegram-desktop gomuks electronic-wechat-uos-bin || exit 1
yay -S --needed --noconfirm qqmusic-bin typioca glow || exit 1
yay -S --needed --noconfirm npm nodejs || exit 1

###

yay -Rns --noconfirm firefox
# yay -Rns vi gnome-terminal gedit

./update.sh

read -p "Press any key to resume ..."

reboot
