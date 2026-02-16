## Proxy

function Set-Proxy {
    $PROXY_SERVER = "127.0.0.1:7897"
    $Env:all_proxy = "socks://$PROXY_SERVER/"
    $Env:http_proxy = "http://$PROXY_SERVER/"
    $Env:https_proxy = $Env:http_proxy
    $Env:no_proxy = "localhost, 127.0.0.0/8, ::1"
}

function Unset-Proxy {
    Remove-Item Env:*proxy* -ErrorAction SilentlyContinue
}

# Set-Proxy

## Alias

# Utility aliases
Set-Alias -Name c -Value clear

if (Get-Command eza -ErrorAction SilentlyContinue) {
    Set-Alias -Name ls -Value eza -Option AllScope
    Set-Alias -Name l -Value eza -Option AllScope
    function ll { eza --long --icons @args }
    function tree { eza --tree @args }
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    function cat { bat -pp @args }
}

if (Get-Command nvim -ErrorAction SilentlyContinue) {
    Set-Alias -Name v -Value nvim
}

if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-Alias -Name lg -Value lazygit
}
if (Get-Command yt-dlp -ErrorAction SilentlyContinue) {
    Set-Alias -Name youtube -Value yt-dlp -Option AllScope
}

if (Get-Command scoop-search -ErrorAction SilentlyContinue) {
    Invoke-Expression (&scoop-search --hook)
}

## PowerShell

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

## Prompt

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
