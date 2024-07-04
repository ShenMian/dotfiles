Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

### Chocolatey

# tab-completions to function for `choco`.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

### Environment

# proxy
$Env:http_proxy = "127.0.0.1:7890"
$Env:https_proxy = "127.0.0.1:7890"

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

### Prompt

# Starship
Invoke-Expression (&starship init powershell)
