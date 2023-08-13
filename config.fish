# Environment
set -Ux all_proxy 'socks5://127.0.0.1:7890/'
set -Ux http_proxy 'http://127.0.0.1:7890/'
set -Ux https_proxy $http_proxy
set -Ux no_proxy 'localhost, 127.0.0.0/8, ::1'

set -x TERM xterm-256color

set -Ux VISUAL 'nvim'
set -Ux EDITOR 'nvim'

fish_add_path -Ua '/home/sms/.cargo/bin/'

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Alias
    alias ls exa
    alias tree 'ls --tree'
    alias cat 'bat -pp'

    alias l ls
    alias c clear
    alias v nvim
    alias vi 'neovide --multigrid'
    alias lg lazygit

    alias youtube yt-dlp
    alias open xdg-open

    set -Ux fish_greeting
end
