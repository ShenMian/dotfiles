#!/bin/bash

source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/deps/shell/src/import.sh"
import io system timer

require yay
require sudo

sudo echo &>/dev/null || (error 'Failed to get sudo permission.'; exit 1)

new Timer timer

info 'Update pacman mirrors'
sudo pacman-mirrors -c China &>/dev/null || error 'Failed to update pacman mirrors'

info 'Upgrade system'
sudo pacman -Syyu || error 'Failed to upgrade system'
yay -Syyu || error 'Failed to upgrade system'

info 'Clean package cache'
sudo pacman -Scc --noconfirm &>/dev/null || error 'Failed to clean package cache'

if [ ! -z "$(pacman -Qtdq)" ]; then
  info 'Remove useless packages'
  sudo pacman -R --noconfirm $(pacman -Qtdq) &>/dev/null || error 'Failed to remove useless packages'
fi

lines=50
info "Clean command history (keep last $lines lines)"
tail -n $(expr $lines + 1) ~/.zhistory | head -n $lines > ~/.zhistory_ && mv ~/.zhistory_ ~/.zhistory

good "Succeed ($(timer.getSeconds) sec)"

delete timer

