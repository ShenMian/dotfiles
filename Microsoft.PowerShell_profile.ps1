### Environment

# $Env:http_proxy = "127.0.0.1:7890"
# $Env:https_proxy = "127.0.0.1:7890"

### Alias

Set-Alias -Name c -Value clear

# bat
Set-Alias -Name cat -Value bat -Option AllScope

# eza
Set-Alias -Name ls -Value eza -Option AllScope
Set-Alias -Name l -Value eza
function ll { eza -la }

# neovim
Set-Alias -Name v -Value nvim

# neovide
Set-Alias -Name vi -Value neovide

# lazygit
Set-Alias -Name lg -Value lazygit

# scoop
Invoke-Expression (&scoop-search --hook)

### PowerShell

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

### Prompt

Invoke-Expression (&starship init powershell)
