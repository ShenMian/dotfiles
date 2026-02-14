# This function is idempotent
function Install-ScoopApp {
    param (
        [Parameter(Position = 0, Mandatory=$true)]
        [string[]]$Apps
    )
    foreach ($app in $Apps) {
        scoop install $app
    }
}

# This function is idempotent
function Install-Scoop {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Host "Scoop is already installed. Skipping..." -ForegroundColor Yellow
        return
    }

    [environment]::setEnvironmentVariable('SCOOP', 'D:\apps\scoop', 'User')
    $env:SCOOP = 'D:\apps\scoop'
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    Install-ScoopApp @("git")

    foreach ($bucket in @("extras", "versions", "nerd-fonts", "java")) {
        scoop bucket add $bucket
    }

    Install-ScoopApp @("sudo", "7zip", "dark", "innounp-unicode")
}

Install-Scoop

$productivity = @("typst", "libreoffice", "zotero", "stirling-pdf") # onlyoffice-desktopeditors, readest, anytype
$multimedia = @("caesium-image-compressor", "exifcleaner", "obs-studio", "yt-dlp", "ffmpeg", "inkscape") # potplayer, kdenlive, krita, imagemagick
$networking = @("telegram", "localsend", "magic-wormhole-rs", "qbittorrent") # element, kdeconnect (signal 支持自更新)

$container = @("podman", "kubectl", "minikube")
$cpp = @("clangd", "llvm", "cmake", "ninja", "vcpkg", "doxygen")
$reverse = @("ghidra", "ida-free", "cutter", "x64dbg", "cheat-engine", "wireshark")
$compression = @("upx", "zstd")
$development = @("rustup", "python", "openjdk", "gh", "scc", "godot", "lazygit", "github", "git-cliff") + $compression

$fonts = @("cascadia-code", "source-han-serif-sc")
$security = @("bitwarden", "gpg4win")
$system = @("alacritty", "bleachbit", "everything", "filelight", "rufus", "ventoy") + $fonts + $security

$utilities = @("eza", "bat", "fd", "ripgrep", "fastfetch", "scc", "starship", "btop")

$apps = $productivity + $multimedia + $networking + $development + $system + $utilities
Install-ScoopApp $apps

gh auth login
gh auth setup-git
gh extension install github/gh-copilot
