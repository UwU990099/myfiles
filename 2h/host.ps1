# Hiding download process bar and bypassing security protocols
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# Disabling Defender Real-Time
Set-MpPreference -DisableRealtimeMonitoring $true


# Enabling Audio
Write-Host "Enabling Audio"
Set-Service -Name Audiosrv -StartupType Automatic | Out-Null
Start-Service -Name "AudioSrv"


# Starting RDP tunnel
Write-Host "Starting RDP tunnel"
Invoke-WebRequest -Uri "https://cloudfalls.vercel.app/api/raw/?path=/Downloads/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip" | Out-Null
New-Item -ItemType Directory -Path "C:\ngrok" -Force | Out-Null
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force | Out-Null
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2aT33hJD0ZrQ8Yq6YwlmxLBEszF_6QXAJiT84FURe7hdMKMDe" -Wait | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/ngrok_startup.bat" -OutFile "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ngrok_startup.bat" | Out-Null
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389"
Remove-Item -Path "C:\ngrok.zip" -Force 

# Customizing desktop shortcuts
Write-Host "Customizing desktop shortcuts"
$desktopPath = "Desktop"
$userProfiles = Get-ChildItem -Path "C:\Users\" -Directory
foreach ($userProfile in $userProfiles) {
    $userDesktopPath = Join-Path -Path $userProfile.FullName -ChildPath $desktopPath
    Remove-Item -Path $userDesktopPath\* -Force -Recurse -Confirm:$false
}
Clear-RecycleBin -Force | Out-Null

# Opening visual effects window
SystemPropertiesPerformance.exe

# Add this computer
$computerRegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$computerIconValueName = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
$defaultValue = 0
New-Item -Path $computerRegistryPath -Force | Out-Null
Set-ItemProperty -Path $computerRegistryPath -Name $computerIconValueName -Value $defaultValue

Stop-Process -Name explorer -Force

# Install apps

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

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
