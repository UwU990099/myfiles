$ProgressPreference = 'SilentlyContinue'

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install internet-download-manager -y --ignore-checksums
Start-Process "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
choco install winrar -y
choco install telegram -y

Invoke-WebRequest -Uri "https://cloudfalls.vercel.app/api/raw/?path=/Softwares/ClipboardZanager.Appx" -OutFile "C:\Users\Administrator\Downloads\ClipboardZanager.Appx"
Add-AppxPackage -Path "C:\Users\Administrator\Downloads\ClipboardZanager.Appx"
Start-Process -FilePath "shell:AppsFolder\64360VelerSoftware.9606A2D6F057_j80j2txgjg9dj!App"


# Create LosslessCut folder
New-Item -ItemType Directory -Path "C:\LosslessCut" -Force

# Download 7z file to Downloads folder
Invoke-WebRequest -Uri "https://github.com/mifi/lossless-cut/releases/latest/download/LosslessCut-win-x64.7z" -OutFile "C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z"

# Wait for the download to complete
while ((Test-Path "C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z.part")) {
    Start-Sleep -Seconds 1
}

# Extract contents using WinRAR
$winrarProcess = Start-Process -FilePath "C:\Program Files\WinRAR\WinRAR.exe" -ArgumentList "x", "`"C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z`"", "`"C:\LosslessCut`"" -PassThru

# Wait for the WinRAR process to finish
while (!$winrarProcess.HasExited) {
    Start-Sleep -Seconds 1
}

Write-Host "Extraction completed."


write-host "done"
# Delete 7z file
Remove-Item "C:\Users\Administrator\Downloads\LosslessCut-win-x64.7z" -Force

# Create desktop shortcut
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("C:\Users\Administrator\Desktop\LosslessCut.lnk")
$shortcut.TargetPath = "C:\LosslessCut\LosslessCut.exe"
$shortcut.Save()
