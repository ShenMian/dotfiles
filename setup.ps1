function Install-Scoop {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        return
    }

    [environment]::setEnvironmentVariable('SCOOP', 'D:\apps\scoop', 'User')
    $env:SCOOP = 'D:\apps\scoop'
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    # Install basic packages
    scoop install git sudo 7zip dark innounp

    # Add basic buckets
    foreach ($bucket in @("main", "extras", "nerd-fonts", "java")) {
        scoop bucket add $bucket
    }
}

Install-Scoop

$fonts = @("cascadia-code", "source-han-serif-sc")
$utilities = @("everything", "caesium-image-compressor", "exifcleaner", "yt-dlp")
$security = @("bitwarden")
$communication = @("telegram", "wechat")
$development = @("rustup", "gh", "godot")

$apps = $fonts + $utilities + $security + $communication + $development

foreach ($app in $apps) {
    scoop install $app
}

gh auth login
gh auth setup-git
gh extension install github/gh-copilot
