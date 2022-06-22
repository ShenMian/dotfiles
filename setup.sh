#!/bin/bash

Color_off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

need_cmd () {
  if ! hash "$1" &>/dev/null; then
    error "需要 '$1' （找不到命令）"
    exit 1
  fi
}

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

info() {
  msg "${Blue}[➭]${Color_off} ${1}${2}"
}

error() {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

warn() {
  msg "${Yellow}[⚠]${Color_off} ${1}${2}"
}

echo_with_color() {
  printf '%b\n' "$1$2$Color_off" >&2
}

# 配置

script_path='~'    # 脚本文件存放位置
repo_path='~/repo' # Git 仓库存放位置

mkdir $script_path
mkdir $repo_path

# 配置脚本
setup_scripts()
{
  cp *.sh $script_path
}

# 配置代理
setup_proxy()
{
  yay -S clash
}

# 配置 neovim
setup_neovim()
{
  # 安装 neovim
  yay -S --noconfirm neovim

  # 安装 SpaceVim
  curl -sLf https://spacevim.org/cn/install.sh | bash

  # 拷贝 SpaceVim 配置
  cp init.toml '~/.SpaceVim.d/'
}

setup_terminal_prompt()
{
  # 安装 powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $repo_path
  echo 'source $repo_path/powerlevel10k/powerlevel10k.zsh-theme' >>'~/.zshrc'

  # 手动配置 powerlevel10k
  p10k configure
}

# 安装输入法
install_input_method()
{
  # 安装 fcitx5 + rime
  yay -S --noconfirm fcitx5 citx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
  
  echo 'export GTK_IM_MODULE=fcitx' >> '~/.xprofile'
  echo 'export QT_IM_MODULE=fcitx' >> '~/.xprofile'
  echo 'XMODIFIERS="@im=fcitx"' >> '~/.xprofile'

  echo 'GTK_IM_MODULE DEFAULT=fcitx' >> '~/.pam_environment'
  echo 'QT_IM_MODULE DEFAULT=fcitx' >> '~/.pam_environment'
  echo 'SDL_IM_MODULE DEFAULT=fcitx' >> '~/.pam_environment'
  echo 'XMODIFIERS DEFAULT="@im=fcitx"' >> '~/.pam_environment'
}

# 安装输入法皮肤
install_input_method_skins()
{
  git clone https://github.com/thep0y/fcitx5-themes $repo_path
  cd $repo_path/fcitx5-themes
  cp spring ~/.local/share/fcitx5/themes -r
  cp winter ~/.local/share/fcitx5/themes -r
  cp autumn ~/.local/share/fcitx5/themes -r
  cp summer ~/.local/share/fcitx5/themes -r
  rm -rf $repo_path/fcitx5-themes

  echo '# Font' >> '~/.config/fcitx5/conf/classicui.conf'
  echo 'Font="Smartisan Compact CNS 13"' >> '~/.config/fcitx5/conf/classicui.conf'
  echo '# 主题' >> '~/.config/fcitx5/conf/classicui.conf'
  echo 'Theme=spring' >> '~/.config/fcitx5/conf/classicui.conf'
  echo '# 垂直候选列表' >> '~/.config/fcitx5/conf/classicui.conf'
  echo 'Vertical Candidate List=False' >> '~/.config/fcitx5/conf/classicui.conf'
  echo '# 按屏幕 DPI 使用' >> '~/.config/fcitx5/conf/classicui.conf'
  echo 'PerScreenDPI=True' >> '~/.config/fcitx5/conf/classicui.conf'

  # 启用候选字符单行显示
  echo 'PreeditInApplication=True' >> '~/.config/fcitx5/conf/rime.conf'
}

# 配置输入法
function setup_input_method()
{
  info '正在安装输入法...'
  install_input_method

  info '正在安装输入法皮肤...'
  install_input_method_skins
}

info '正在配置脚本...'
setup_scripts

info '正在配置代理...'
setup_proxy

info '正在全面更新...'
./update.sh

info '正在配置输入法...'
setup_input_method

info '正在配置 neovim ...'
setup_neovim

info '正在配置终端命令提示符...'
setup_terminal_prompt

info '完毕'

