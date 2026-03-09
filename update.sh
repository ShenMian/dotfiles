#!/bin/bash

cd "$( cd "$( dirname "$0"  )" && pwd  )" || exit

# .fonts.conf
ln -sf "$PWD/.fonts.conf" ~/.fonts.conf

# fish
ln -sf "$PWD/config.fish" ~/.config/fish/config.fish
ln -sf "$PWD/secrets.fish" ~/.config/fish/secrets.fish

# mpv
ln -sf "$PWD/mpv" ~/.config/

# alacritty
ln -sf "$PWD/alacritty" ~/.config/

# ghostty
# ln -sf "$PWD/ghostty" ~/.config/

# kitty
# ln -sf "$PWD/kitty" ~/.config/

# wezterm
# ln -sf "$PWD/wezterm" ~/.config/

# neovim
ln -sf "$PWD/astronvim" ~/.config/nvim

# neovide
ln -sf "$PWD/neovide" ~/.config/

# helix
# ln -sf "$PWD/helix" ~/.config/

# lazygit
ln -sf "$PWD/lazygit/config.yml" ~/.config/lazygit/config.yml

# lf
# ln -sf "$PWD/lf" ~/.config/

# tmux
# ln -sf "$PWD/tmux/.tmux.conf.local" ~/.tmux.conf.local

# zsh
# ln -sf "$PWD/.zshrc" ~/.zshrc
