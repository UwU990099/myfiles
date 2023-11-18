Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install internet-download-manager -y
choco install winrar -y
choco install telegram -y

$ProgressPreference = 'SilentlyContinue'

# Download 7z file to Downloads folder
Invoke-WebRequest -Uri "https://github.com/mifi/lossless-cut/releases/latest/download/LosslessCut-win-x64.7z" -OutFile "C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z"

# Wait for the download to complete
while ((Test-Path "C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z.part")) {
    Start-Sleep -Seconds 1
}

# Extract contents using WinRAR
& "C:\Program Files\WinRAR\WinRAR.exe" x "C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z" "C:\LosslessCut"

# Delete 7z file
Remove-Item "C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z" -Force

# Create desktop shortcut
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("C:\Users\Administrator\Desktop\LosslessCut.lnk")
$shortcut.TargetPath = "C:\LosslessCut\LosslessCut.exe"
$shortcut.Save()
