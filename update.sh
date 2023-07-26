#!/bin/bash

cd "$( cd "$( dirname "$0"  )" && pwd  )" || exit

# zsh
# ln -sf "$PWD/.zshrc" ~/.zshrc

# fish
ln -sf "$PWD/config.fish" ~/.config/fish/config.fish

# lf
# ln -sf "$PWD/lf" ~/.config/

# neovim
ln -sf "$PWD/astronvim" ~/.config/nvim/lua/user

# lazygit
ln -sf "$PWD/lazygit/config.yml" ~/.config/lazygit/config.yml

# wezterm
# ln -sf "$PWD/wezterm" ~/.config/

# kitty
ln -sf "$PWD/kitty" ~/.config/

# alacritty
# ln -sf "$PWD/alacritty" ~/.config/

# tmux
# ln -sf "$PWD/tmux/.tmux.conf.local" ~/.tmux.conf.local
