# Hiding download process bar and bypassing security protocols
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

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

function Unpin-App([string]$appname) {
    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() |
        ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt()}
}; Unpin-App("Internet Explorer");

# Enabling taskbar icons
Write-Host "Enabling taskbar icons"
New-Item -ItemType Directory -Path "C:\LGPO" -Force  | Out-Null
New-Item -ItemType Directory -Path "C:\gp" -Force | Out-Null
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/LGPO.exe" -OutFile "C:\LGPO\LGPO.exe"  | Out-Null
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/gp.zip" -OutFile "C:\gp.zip" | Out-Null
Expand-Archive -Path "C:\gp.zip" -DestinationPath "C:\gp" -Force | Out-Null
& "C:\LGPO\LGPO.exe" /g "C:\gp" > $null 2>&1
Remove-Item -Path "C:\gp" -Recurse -Force 
Remove-Item -Path "C:\LGPO" -Recurse -Force 
Remove-Item -Path "C:\gp.zip" -Force

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


# Enabling Audio
Write-Host "Enabling Audio"
Set-Service -Name Audiosrv -StartupType Automatic | Out-Null
Start-Service -Name "AudioSrv"
