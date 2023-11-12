[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -Force
$ProgressPreference = 'SilentlyContinue'

# Make folders
New-Item -ItemType Directory -Path "C:\LGPO" -Force
New-Item -ItemType Directory -Path "C:\gp" -Force

# Download LGPO
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/LGPO.exe" -OutFile "C:\LGPO\LGPO.exe"

# Download GP Backup
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/gp.zip" -OutFile "C:\gp.zip"

# Extract GP Backup
Expand-Archive -Path "C:\gp.zip" -DestinationPath "C:\gp" -Force

# Import GP
& "C:\LGPO\LGPO.exe" /g "C:\gp"

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

# Download Ngrok
Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip"

# Create directory
New-Item -ItemType Directory -Path "C:\ngrok" -Force

# Extract ngrok.zip to C:\ngrok
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force

# Set ngrok authtoken
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu" -Wait

# Create or modify user (change password)
net user Administrator HenryRH9!

# Run ngrok with specified parameters
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/ngrok_startup.ps1" -OutFile "C:\ngrok\ngrok_startup.ps1"

# Specify the path to your PowerShell script
$scriptPath = "C:\ngrok\ngrok_startup.ps1"

# Specify the registry key
$registryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"

# Specify the name for the registry entry
$registryEntryName = "NgrokStartupScript"

# Set the registry entry value to the path of your PowerShell script
Set-ItemProperty -Path $registryKey -Name $registryEntryName -Value $scriptPath

# Close window
exit
