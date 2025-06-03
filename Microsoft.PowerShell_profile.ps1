### PowerShell
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

### Environment
$Env:all_proxy = "127.0.0.1:7897"
$Env:http_proxy = "127.0.0.1:7897"
$Env:https_proxy = $Env:http_proxy
$Env:no_proxy = "localhost,127.0.0.0/8,::1"

### Alias
Set-Alias -Name c -Value clear

# eza
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Set-Alias -Name ls -Value eza -Option AllScope
    Set-Alias -Name l -Value eza -Option AllScope
    function ll { eza --long --icons @args }
    function tree { eza --tree @args }
}

# bat
if (Get-Command bat -ErrorAction SilentlyContinue) {
    function cat { bat -pp @args }
}

Set-Alias -Name v -Value nvim
Set-Alias -Name vi -Value neovide
Set-Alias -Name hx -Value helix -Option AllScope
Set-Alias -Name lg -Value lazygit
Set-Alias -Name youtube -Value yt-dlp -Option AllScope

# scoop-search
if (Get-Command scoop-search -ErrorAction SilentlyContinue) {
    Invoke-Expression (&scoop-search --hook)
}

### Prompt
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
