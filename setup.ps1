[environment]::setEnvironmentVariable('SCOOP', 'D:\apps\scoop', 'User')
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop install git sudo 7zip dark innounp

scoop bucket add extras nerd-fonts

$font = @("cascadia-code")
$utilities = @("everything")
$security = @("bitwarden")
$communication = @("telegram", "element", "wechat")
$development = @("vscode", "neovim", "rustup", "gh")

$apps = $font + $utilities + $security + $communication + $development

foreach ($app in $apps) {
    scoop install $package
}

gh auth login
gh auth setup-git
gh extension install github/gh-copilot

