#!/bin/bash

cd "$( cd "$( dirname "$0"  )" && pwd  )" || exit

# zsh
ln -sf "$PWD/.zshrc" ~/.zshrc

# kitty
ln -sf "$PWD/kitty" ~/.config/

# lf
ln -sf "$PWD/lf" ~/.config/

# neovim
ln -sf "$PWD/astronvim" ~/.config/nvim/lua/user

# tmux
ln -sf "$PWD/tmux/.tmux.conf.local" ~/.tmux.conf.local

# lazygit
ln -sf "$PWD/lazygit/config.yml" ~/.config/lazygit/config.yml

# alacritty
# ln -sf "$PWD/alacritty" ~/.config/
