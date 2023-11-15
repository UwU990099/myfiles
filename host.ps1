[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
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

# Download Ngrok
Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip"

# Create directory
New-Item -ItemType Directory -Path "C:\ngrok" -Force

# Extract ngrok.zip to C:\ngrok
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force

# Set ngrok authtoken
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu" -Wait

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/ngrok_startup.bat" -OutFile "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ngrok_startup.bat"

# Create or modify user (change password)
net user Administrator HenryRH9!

# Automating keybaord
# Step 1: Press Windows + R
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("^{ESC}")

# Wait for the Run dialog to open
Start-Sleep -Milliseconds 500

# Step 2: Type gpedit.msc and press Enter
[System.Windows.Forms.SendKeys]::SendWait("gpedit.msc")
Start-Sleep -Milliseconds 500

# Wait for the Local Group Policy Editor to launch
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Seconds 2

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

# Close window
exit
