#!/bin/bash

cd "$( cd "$( dirname "$0"  )" && pwd  )" || exit

# fish
ln -sf "$PWD/config.fish" ~/.config/fish/config.fish

# neovim
ln -sf "$PWD/astronvim" ~/.config/nvim

# lazygit
ln -sf "$PWD/lazygit/config.yml" ~/.config/lazygit/config.yml

# wezterm
ln -sf "$PWD/wezterm" ~/.config/

# kitty
# ln -sf "$PWD/kitty" ~/.config/

# alacritty
# ln -sf "$PWD/alacritty" ~/.config/

# lf
# ln -sf "$PWD/lf" ~/.config/

# tmux
# ln -sf "$PWD/tmux/.tmux.conf.local" ~/.tmux.conf.local

# zsh
# ln -sf "$PWD/.zshrc" ~/.zshrc

