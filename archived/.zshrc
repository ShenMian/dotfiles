### Tmux

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  # exec tmux new-session -A -s main
  exec tmux
fi

### Powerlevel10k

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Plugins

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

### Rust

# source "$HOME/.cargo/env"

### Environment

# export ALL_PROXY='http://127.0.0.1:7890/'
export all_proxy='http://127.0.0.1:7890/'
# export http_proxy='http://127.0.0.1:7890/'
# export https_proxy='http://127.0.0.1:7890/'

export VISUAL='nvim'
export EDITOR='nvim'
export PATH="${PATH}:/home/sms/.cargo/bin"

### Alias

alias grep='ag'
alias cat='bat -pp'
eval "$(zoxide init zsh)"
alias cd='z'
alias ls='exa --group-directories-first --color=auto'
alias open='xdg-open'

alias ll='ls -al'
alias tree='exa --tree'
alias l='ls'
alias c='clear'

alias neovide='neovide --multigrid'
alias vi='neovide'
alias v='nvim'
alias lg='lazygit'
alias mutt='neomutt'
alias yay='yay --color=auto'
alias gdb='gdb -q'
alias r2='r2 -AA'

alias 'proxy'='export all_proxy=socks5://127.0.0.1:7891'
alias 'unproxy'='unset all_proxy'

alias hackernews='hackernews_tui'
alias reddit='rtv'
alias youtube='yt-dlp -S "res:1080"'

source /home/sms/.config/broot/launcher/bash/br
