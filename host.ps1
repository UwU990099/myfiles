[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

Write-Host "Unpinning apps from start menu"
# Unpin apps from start menu
function Pin-App {    param(
        [string]$appname,
        [switch]$unpin
    )
    try{
        if ($unpin.IsPresent){
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Von "Start" lösen|Unpin from Start'} | %{$_.DoIt()}
            return "App '$appname' unpinned from Start"
        }else{
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'An "Start" anheften|Pin to Start'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
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
[System.Windows.Forms.SendKeys]::SendWait('{LWin}')
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait('{LWin}')
Start-Sleep -Milliseconds 500

Write-Host "Enabling Audio"

# Set the 'Windows Audio' service to 'Automatic'
Set-Service -Name Audiosrv -StartupType Automatic | Out-Null

# Start audio service
Start-Service -Name "AudioSrv"

Write-Host "Importing group policies"

# Make folders
New-Item -ItemType Directory -Path "C:\LGPO" -Force  | Out-Null
New-Item -ItemType Directory -Path "C:\gp" -Force | Out-Null

# Download LGPO
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/LGPO.exe" -OutFile "C:\LGPO\LGPO.exe"  | Out-Null

# Download GP Backup
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/gp.zip" -OutFile "C:\gp.zip" | Out-Null

# Extract GP Backup
Expand-Archive -Path "C:\gp.zip" -DestinationPath "C:\gp" -Force | Out-Null

# Import GP
& "C:\LGPO\LGPO.exe" /g "C:\gp" > $null 2>&1

Write-Host "Starting RDP tunnel"

# Download Ngrok
Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip" | Out-Null

# Create directory
New-Item -ItemType Directory -Path "C:\ngrok" -Force | Out-Null

# Extract ngrok.zip to C:\ngrok
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force | Out-Null

# Set ngrok authtoken
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu" -Wait | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/ngrok_startup.bat" -OutFile "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ngrok_startup.bat" | Out-Null

# Create or modify user (change password)
net user Administrator HenryRH9! | Out-Null

# Restart Explorer
taskkill /f /im explorer.exe
start explorer.exe

# Run ngrok with specified parameters
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389"
