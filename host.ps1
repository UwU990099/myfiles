# Hiding download process bar and bypassing security protocols
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

(Get-ItemProperty -path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome').version | ForEach-Object {& ${env:ProgramFiles(x86)}\Google\Chrome\Application\$_\Installer\setup.exe --uninstall --multi-install --chrome --system-level --force-uninstall}

# Installing Edge
# [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
# md -Path $env:temp\edgeinstall -erroraction SilentlyContinue | Out-Null
# $Download = join-path $env:temp\edgeinstall MicrosoftEdgeEnterpriseX64.msi
# Invoke-WebRequest 'http://go.microsoft.com/fwlink/?LinkID=2093437'  -OutFile $Download
# Start-Process "$Download" -ArgumentList "/quiet"

# Disabling Defender Real-Time
# Set-MpPreference -DisableRealtimeMonitoring $true

# Unpin apps from start menu
Write-Host "Unpinning apps from start menu"
function Pin-App {    param(
        [string]$appname,
        [switch]$unpin
    )
    try{
        if ($unpin.IsPresent){
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Von "Start" lösen|Unpin from Start'} | %{$_.DoIt()}
        }else{
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'An "Start" anheften|Pin to Start'} | %{$_.DoIt()}
        }
    }catch{
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
    }
}

Pin-App "Server Manager" -unpin
Pin-App "Windows PowerShell" -unpin
Pin-App "Windows PowerShell ISE" -unpin
Pin-App "Windows Administrative Tools" -unpin
Pin-App "Task Manager" -unpin
Pin-App "Control Panel" -unpin
Pin-App "Remote Desktop Connection" -unpin
Pin-App "Event Viewer" -unpin
Pin-App "File Explorer" -unpin

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait('^{ESC}')
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait('^{ESC}')
Start-Sleep -Milliseconds 500

# Freeing up space
Write-Host "Freeing up space"
Remove-Item -Path "C:\Program Files\RStudio" -Recurse -Force
Remove-Item -Path "C:\Program Files\LibreOffice" -Recurse -Force
Remove-Item -Path "C:\Users\Administrator\AppData\Local\Programs" -Recurse -Force
Remove-Item -Path "C:\Users\Administrator\AppData\Local\GitHubDesktop" -Recurse -Force
Start-Process -FilePath "C:\Program Files\R\R-3.6.3\unins000.exe" -ArgumentList "/Silent"
Start-Process -FilePath "C:\Program Files\Git\unins000.exe" -ArgumentList "/Silent"

# Enabling Audio
Write-Host "Enabling Audio"
Set-Service -Name Audiosrv -StartupType Automatic | Out-Null
Start-Service -Name "AudioSrv"

# Enabling taskbar icons
Write-Host "Enabling taskbar icons"
New-Item -ItemType Directory -Path "C:\LGPO" -Force  | Out-Null
New-Item -ItemType Directory -Path "C:\gp" -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/LGPO.exe" -OutFile "C:\LGPO\LGPO.exe"  | Out-Null
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/gp.zip" -OutFile "C:\gp.zip" | Out-Null
Expand-Archive -Path "C:\gp.zip" -DestinationPath "C:\gp" -Force | Out-Null
& "C:\LGPO\LGPO.exe" /g "C:\gp" > $null 2>&1

# Starting RDP tunnel
Write-Host "Starting RDP tunnel"
Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip" | Out-Null
New-Item -ItemType Directory -Path "C:\ngrok" -Force | Out-Null
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force | Out-Null
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu" -Wait | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/ngrok_startup.bat" -OutFile "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ngrok_startup.bat" | Out-Null
net user Administrator HenryRH9! | Out-Null
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389"

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

# Cleaning up
Remove-Item -Path "C:\gp" -Recurse -Force 
Remove-Item -Path "C:\LGPO" -Recurse -Force 
Remove-Item -Path "C:\Ruby*" -Recurse -Force 
Remove-Item -Path "C:\gp.zip" -Force 
Remove-Item -Path "C:\ngrok.zip" -Force 

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

# Refresh the desktop to apply changes
Stop-Process -Name explorer -Force
