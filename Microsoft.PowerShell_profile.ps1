### PowerShell

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

### Environment

# $Env:http_proxy = "127.0.0.1:7897"
# $Env:https_proxy = "127.0.0.1:7897"

### Alias

Set-Alias -Name c -Value clear

# bat
if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name cat -Value bat -Option AllScope
}

# eza
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Set-Alias -Name ls -Value eza -Option AllScope
    function ll { eza -la @args }
}

# neovim
Set-Alias -Name v -Value nvim

# neovide
Set-Alias -Name vi -Value neovide

# lazygit
Set-Alias -Name lg -Value lazygit

# scoop-search
Invoke-Expression (&scoop-search --hook)

### Prompt

Invoke-Expression (&starship init powershell)
