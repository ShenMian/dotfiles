## Proxy

function set_proxy -d "Set proxy environment variables"
    set -l PROXY_SERVER "127.0.0.1:7890"

    set -gx all_proxy "socks://$PROXY_SERVER/"
    set -gx http_proxy "http://$PROXY_SERVER/"
    set -gx https_proxy $http_proxy
    set -gx no_proxy "localhost,127.0.0.0/8,::1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12"

    # Uppercase for compatibility
    set -gx ALL_PROXY $all_proxy
    set -gx HTTP_PROXY $http_proxy
    set -gx HTTPS_PROXY $https_proxy
    set -gx NO_PROXY $no_proxy
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

set_proxy

## Environment

# set -x TERM xterm-256color

if type -q nvim
    set -gx VISUAL "nvim"
    set -gx EDITOR "nvim"
    set -gx MANPAGER "nvim +Man!"
end

set -gx GPG_TTY (tty)

if test -f (dirname (status -f))/secrets.fish
    source (dirname (status -f))/secrets.fish
end

fish_add_path -a "$HOME/.cargo/bin/"

if status is-interactive
    # Remove fish greeting message
    set -g fish_greeting

    ## Alias

    # Utility aliases
    if type -q eza
        alias ls="eza"
        alias l="ls"
        alias ll="eza --long --icons"
        alias tree="eza --tree"
    else
        alias l="ls"
        alias ll="ls --long"
    end
    if type -q bat
        alias cat="bat -pp"
    end
    alias c="clear"

    # Editor aliases
    if type -q zeditor
        alias zed="zeditor"
    end
    if type -q nvim
        alias v="nvim"
    end
    if type -q neovide
        alias vi="neovide"
    end
    if type -q helix
        alias hx="helix"
    end

    # Tool aliases
    if type -q lazygit
        alias lg="lazygit"
    end
    if type -q yt-dlp
        alias youtube="yt-dlp"
    end
    if type -q xdg-open
        alias open="xdg-open"
    end
end

# Force standard key bindings (overrides implicit Vi mode from EDITOR=nvim)
fish_default_key_bindings
