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
    error "Need '$1' (Command not found)"
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
}

warn() {
  msg "${Yellow}[⚠]${Color_off} ${1}${2}"
}

echo_with_color() {
  printf '%b\n' "$1$2$Color_off" >&2
}

help()
{
    echo "Manage clash proxy."
    echo ""
    echo "Usage : proxy [command]"
    echo ""
    echo "COMMANDS"
    echo ""
    echo " update Update config file"
    echo " start  Start clash"
    echo " stop   Stop clash"
    echo " setup  Add proxy environment variables"
}

setup()
{
  local port=$1

  echo "set HTTP_PROXY=127.0.0.1:$1" >> ~/.zshrc
  echo "set HTTPS_PROXY=127.0.0.1:$1" >> ~/.zshrc

  success 'Done'
  warn 'This modification takes effect after the configuration file is reloaded'
}

iptables_init()
{
  # 设置 iptables
  sudo iptables -t nat -N CLASH
  
  # 8080 是 ss 代理服务器的端口，即远程 CLASH 服务器提供服务的端口，如果你有多个 ip 可用,但端口一致，就设置这个
  sudo iptables -t nat -A CLASH -p tcp --dport 8080 -j RETURN
  
  # 192.192.192.192 是 CLASH 代理服务器的 ip, 如果你只有一个 CLASH服务器的 ip，却能选择不同端口,就设置此条
  sudo iptables -t nat -A CLASH -d 192.192.192.192 -j RETURN
  
  # 保留地址/私有地址/回环地址 不走代理
  sudo iptables -t nat -A CLASH -d 0.0.0.0/8 -j RETURN
  sudo iptables -t nat -A CLASH -d 10.0.0.0/8 -j RETURN
  sudo iptables -t nat -A CLASH -d 127.0.0.0/8 -j RETURN
  sudo iptables -t nat -A CLASH -d 169.254.0.0/16 -j RETURN
  sudo iptables -t nat -A CLASH -d 172.16.0.0/12 -j RETURN
  sudo iptables -t nat -A CLASH -d 192.168.0.0/16 -j RETURN
  sudo iptables -t nat -A CLASH -d 224.0.0.0/4 -j RETURN
  sudo iptables -t nat -A CLASH -d 240.0.0.0/4 -j RETURN
  
  sudo iptables -t nat -A CLASH -p tcp -j REDIRECT --to-ports $port
  
  sudo iptables -t nat -A PREROUTING -p tcp -j CLASH
}

iptables_deinit()
{
  # 清除 iptables
  sudo iptables -t nat -D PREROUTING -p tcp -j CLASH
  sudo iptables -t nat -F CLASH
  sudo iptables -t nat -X CLASH
}

clash_start()
{
  local port=$1

  info 'Starting the clash service...'
  systemctl --user restart clash

  # if [ -n "$(pidof clash | sed "s/$//g")" ]; then
  #   error 'Clash already started'
  #   return 1
  # fi
  # clash > /dev/null 2>&1 &
  # iptables_init

  success 'Done'
}

clash_stop()
{
  info 'Stopping the clash service...'

  systemctl --user stop clash

  # iptables_deinit
  # if [ -z "$(pidof clash | sed "s/$//g")" ]; then
  #   error 'Clash already stopped'
  #   return 1
  # fi
  # kill -9 $(pidof clash | sed "s/$//g") &>/dev/null || (error 'Failed to stop the clash'; return 1)
  #
  success 'Succeed'
}

clash_update()
{
  local url=$1

  info 'Updating the proxy server lists...'

  clash_config_path="/home/sms/.config/clash"
  # clash_config_path="$HOME/.config/clash"
  
  info 'Downloading config file using proxy'
  curl --connect-timeout 3 --silent -L "$url" -o "$clash_config_path/config.yaml_" || {
    warn 'Failed to download using proxy'
    info "Downloading config file without proxy"
    curl --retry 3 --noproxy '*' --connect-timeout 3 --silent -L "$url" -o "$clash_config_path/config.yaml_" || {
      error 'Failed to download config file'
      return 1
    }
  }
  mv "$clash_config_path/config.yaml_" "$clash_config_path/config.yaml" || return 1
  success 'Succeed'
}

service()
{
  local url=$1

  clash_start
  while :; do
    sleep 1m
    clash_update "$url" || true
  done 
}

main()
{
  need_cmd clash

  local url="<url>"
  local port=7897

  if [ -z "$1" ]; then
    clash_start $port
  elif [ "$1" == 'stop' ]; then
    clash_stop
  elif [ "$1" == 'update' ]; then
    clash_update "$url"
    clash_start $port
  elif [ "$1" == 'setup' ]; then
    setup $port
  elif [ "$1" == 'service' ]; then
    service "$url" 
  elif [ "$1" == '--help' ]; then
    help
  else
    error 'Unknown arguments'
  fi
}

main "$@"
