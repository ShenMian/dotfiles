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

# exa
Set-Alias -Name ls -Value exa -Option AllScope
Set-Alias -Name l -Value exa
function ll { exa -la }

# neovim
Set-Alias -Name v -Value nvim

# neovide
function vi { neovide --multigrid $args }

# lazygit
Set-Alias -Name lg -Value lazygit

### Prompt

# Starship
Invoke-Expression (&starship init powershell)