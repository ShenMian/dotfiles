# Environment

# set -Ux all_proxy 'socks://127.0.0.1:7890/'
# set -Ux http_proxy 'http://127.0.0.1:7890/'
# set -Ux https_proxy $http_proxy
# set -Ux no_proxy 'localhost, 127.0.0.0/8, ::1'

# set -x TERM xterm-256color

set -Ux VISUAL nvim
set -Ux EDITOR nvim
set -Ux MANPAGER 'nvim +Man!'

fish_add_path -Ua "$HOME/.cargo/bin/"

if status is-interactive
    # Remove fish greeting message
    set -Ux fish_greeting

    # File management aliases
    alias ls eza
    alias l ls
    alias tree 'ls --tree'

    # Text viewing/editing aliases
    alias cat 'bat -pp'
    alias v nvim
    alias vi neovide
    alias hx helix

    # Utility aliases
    alias c clear
    alias lg lazygit
    alias youtube yt-dlp
    alias open xdg-open
end
