## Proxy

function set_proxy -d "Set proxy environment variables"
    set -l PROXY_SERVER "127.0.0.1:7897"

    set -Ux all_proxy "socks://$PROXY_SERVER/"
    set -Ux http_proxy "http://$PROXY_SERVER/"
    set -Ux https_proxy $http_proxy
    set -Ux no_proxy "localhost, 127.0.0.0/8, ::1"

    set -Ux ALL_PROXY $all_proxy
    set -Ux HTTP_PROXY $http_proxy
    set -Ux HTTPS_PROXY $https_proxy
    set -Ux NO_PROXY $no_proxy
end

function unset_proxy -d "Remove proxy environment variables"
    set -e all_proxy
    set -e http_proxy
    set -e https_proxy
    set -e no_proxy

    set -e ALL_PROXY
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    set -e NO_PROXY
end

# set_proxy

## Environment

# set -x TERM xterm-256color

set -Ux VISUAL "nvim"
set -Ux EDITOR "nvim"
set -Ux MANPAGER "nvim +Man!"

set -gx GPG_TTY (tty)

if test -f (dirname (status -f))/secrets.fish
    source (dirname (status -f))/secrets.fish
end

fish_add_path -Ua "$HOME/.cargo/bin/"

if status is-interactive
    # Remove fish greeting message
    set -g fish_greeting

    ## Alias

    # Utility aliases
    alias ls="eza"
    alias l="ls"
    alias ll="eza --long --icons"
    alias tree="ls --tree"
    alias cat="bat -pp"
    alias c="clear"

    # Editor aliases
    alias zed="zeditor"
    alias v="nvim"
    alias vi="neovide"
    alias hx="helix"

    # Tool aliases
    alias lg="lazygit"
    alias youtube="yt-dlp"
    alias open="xdg-open"
end

# Force standard key bindings (overrides implicit Vi mode from EDITOR=nvim)
fish_default_key_bindings
