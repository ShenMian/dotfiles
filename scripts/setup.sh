#!/bin/bash

source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/deps/shell/src/import.sh"
import io system timer

# 配置
script_path="$HOME"     # 脚本文件存放位置
repo_path="$HOME/Repos" # Git 仓库存放位置

mkdir $script_path
mkdir $repo_path

setup_scripts()
{
  cp *.sh "$script_path"
}

setup_proxy()
{
  yay -S clash
}

setup_neovim()
{
  # Install neovim
  yay -S --noconfirm neovim

  # Config by AstroNvim
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  nvim +PackerSync
}

setup_terminal_prompt()
{
  # 安装 powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $repo_path
  echo "source $repo_path/powerlevel10k/powerlevel10k.zsh-theme" >> "$HOME/.zshrc"

  # 手动配置 powerlevel10k
  p10k configure
}

install_input_method()
{
  # 安装 fcitx5 + rime
  yay -S --noconfirm fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
  
  {
    echo 'export GTK_IM_MODULE=fcitx';
    echo 'export QT_IM_MODULE=fcitx';
    echo 'XMODIFIERS="@im=fcitx"';
  } >> "$HOME/.xprofile"

  {
    echo 'GTK_IM_MODULE DEFAULT=fcitx';
    echo 'QT_IM_MODULE DEFAULT=fcitx';
    echo 'SDL_IM_MODULE DEFAULT=fcitx';
    echo 'XMODIFIERS DEFAULT="@im=fcitx"';
  } >> "$HOME/.pam_environment"
}

install_input_method_skins()
{
  git clone https://github.com/thep0y/fcitx5-themes $repo_path
  cd "$repo_path/fcitx5-themes" || exit 1
  cp spring ~/.local/share/fcitx5/themes -r
  cp winter ~/.local/share/fcitx5/themes -r
  cp autumn ~/.local/share/fcitx5/themes -r
  cp summer ~/.local/share/fcitx5/themes -r
  rm -rf "$repo_path/fcitx5-themes"

  {
    echo '# Font';
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
}

setup_input_method()
{
  info 'Install input method'
  install_input_method

  info 'Install input method skins'
  install_input_method_skins
}

requires yay
requires sudo
requires git

sudo echo &>/dev/null || (error 'Failed to get sudo permission.'; exit 1)

new Timer timer

info 'Setup scripts'
setup_scripts

info 'Setup proxy'
setup_proxy

full system upgrades
info 'Upgrade system'
./update.sh

info 'Setup input method'
setup_input_method

info 'Setup terminal prompt'
setup_terminal_prompt

info 'Setup neovim'
setup_neovim
  
good "Succeed ($(timer.getSeconds) sec)"

delete timer

