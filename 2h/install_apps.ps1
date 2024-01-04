# Hiding download process bar
$ProgressPreference = 'SilentlyContinue'

# Installing Chocolatey + Apps
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install internet-download-manager -y --ignore-checksums
choco install winrar -y
choco install telegram -y

# Installing ClipboardZanager
Invoke-WebRequest -Uri "https://cloudfalls.vercel.app/api/raw/?path=/Softwares/ClipboardZanager.Appx" -OutFile "C:\Users\localadmin\Downloads\ClipboardZanager.Appx"
Add-AppxPackage -Path "C:\Users\localadmin\Downloads\ClipboardZanager.Appx"
Start-Process -FilePath "shell:AppsFolder\64360VelerSoftware.9606A2D6F057_j80j2txgjg9dj!App"
rm "C:\Users\localadmin\Downloads\ClipboardZanager.Appx" -force

# Installing MacroRecorder
Invoke-WebRequest -Uri "https://cloudfalls.vercel.app/api/raw/?path=/Downloads/MacroRecorderSetup.exe" -OutFile "C:\Users\localadmin\Downloads\MacroRecorderSetup.exe"
Start-Process -FilePath "C:\Users\localadmin\Downloads\MacroRecorderSetup.exe" -ArgumentList "/Silent" -Wait
rm "C:\Users\localadmin\Downloads\MacroRecorderSetup.exe" -force

# Installing LosslessCut
New-Item -ItemType Directory -Path "C:\LosslessCut" -Force
Invoke-WebRequest -Uri "https://github.com/mifi/lossless-cut/releases/latest/download/LosslessCut-win-x64.7z" -OutFile "C:\Users\localadmin\Downloads\LosslessCut-win-x64.7z"
while ((Test-Path "C:\Users\localadmin\Downloads\LosslessCut-win-x64.7z.part")) {
    Start-Sleep -Seconds 1
}
$winrarProcess = Start-Process -FilePath "C:\Program Files\WinRAR\WinRAR.exe" -ArgumentList "x", "`"C:\Users\localadmin\Downloads\LosslessCut-win-x64.7z`"", "`"C:\LosslessCut`"" -PassThru
while (!$winrarProcess.HasExited) {
    Start-Sleep -Seconds 1
}
Remove-Item "C:\Users\localadmin\Downloads\LosslessCut-win-x64.7z" -Force
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("C:\Users\localadmin\Desktop\LosslessCut.lnk")
$shortcut.TargetPath = "C:\LosslessCut\LosslessCut.exe"
$shortcut.Save()
