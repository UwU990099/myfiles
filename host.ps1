[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# Enable Audio
# URL to download the zip file
$downloadUrl = 'https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip'

# Path to the downloads folder
$downloadsFolder = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')

# Path to the VBCable folder
$vbcableFolder = [System.IO.Path]::Combine($downloadsFolder, 'VBCable')

# Path to the downloaded zip file
$zipFilePath = [System.IO.Path]::Combine($downloadsFolder, 'VBCABLE_Driver_Pack43.zip')

# Path to the setup executable
$setupExePath = [System.IO.Path]::Combine($vbcableFolder, 'VBCABLE_Setup_x64.exe')

# Download the zip file
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFilePath | Out-Null

# Create the VBCable folder
New-Item -ItemType Directory -Force -Path $vbcableFolder | Out-Null

# Extract the contents of the zip file to the VBCable folder
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $vbcableFolder)

# Delete the downloaded zip file
Remove-Item -Path $zipFilePath -Force

# Open the setup executable
Start-Process -FilePath $setupExePath

# Set the 'Windows Audio' service to 'Automatic'
Set-Service -Name Audiosrv -StartupType Automatic | Out-Null

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


# Automating keybaord
# Step 1: Open Local Group Policy Editor
Start-Process "gpedit.msc"

# Wait for the Local Group Policy Editor to launch
Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Seconds 2.5

# Navigation in Local Group Policy Editor
1..8 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }

# Wait for 0.5 seconds
Start-Sleep -Milliseconds 500

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")

1..3 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Wait for 1 second
Start-Sleep -Seconds 1

# Tab 2 times
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{TAB}") }

Start-Sleep -Milliseconds 500

# Press Up arrow key
[System.Windows.Forms.SendKeys]::SendWait("{UP}")

# Press Enter
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Press Alt + F4 to close Local Group Policy Editor
[System.Windows.Forms.SendKeys]::SendWait("%{F4}")

# Change wallpaper
# Specify the path to the default Windows 10 wallpaper
$wallpaperPath = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"


# Set the wallpaper using the SystemParametersInfo function
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Wallpaper {
        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@

[Wallpaper]::SystemParametersInfo(0x0014, 0, $wallpaperPath, 0x01)

# Restart explorer
Stop-Process -Name explorer -Force
Start-Process explorer


# Run ngrok with specified parameters
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389"
