Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install internet-download-manager -y
choco install winrar -y
choco install telegram -y

$ProgressPreference = 'SilentlyContinue'

# Define paths
$losslessCutFolder = "C:\LosslessCut"
$tempDir = [System.IO.Path]::GetTempPath()
$downloadUrl = "https://github.com/mifi/lossless-cut/releases/latest/download/LosslessCut-win-x64.7z"
$downloadedFile = Join-Path $tempDir "LosslessCut-win-x64.7z"
$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
$losslessCutExe = Join-Path $losslessCutFolder "LosslessCut.exe"
$desktopShortcut = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Desktop"), "LosslessCut.lnk")

# Create LosslessCut folder
New-Item -ItemType Directory -Path $losslessCutFolder -Force

# Download 7z file to temp directory
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadedFile

# Extract contents using WinRAR
& $winrarPath x $downloadedFile $losslessCutFolder

# Delete 7z file
Remove-Item $downloadedFile -Force

# Create desktop shortcut
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($desktopShortcut)
$shortcut.TargetPath = $losslessCutExe
$shortcut.Save()
