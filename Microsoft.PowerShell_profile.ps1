### Prompt

# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression

### Chocolatey

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

### Key bindings

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

### Environment

$Env:http_proxy = "127.0.0.1:7890"
$Env:https_proxy = "127.0.0.1:7890"

### Alias

Set-Alias -Name cat -Value bat -Option AllScope
Set-Alias -Name ls -Value exa -Option AllScope
Set-Alias -Name l -Value exa
function ll { exa -la }
Set-Alias -Name c -Value clear
Set-Alias -Name v -Value nvim
function vi { neovide --multigrid $args }
Set-Alias -Name lg -Value lazygit

clear
