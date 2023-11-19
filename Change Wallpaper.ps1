# Step 1: Open Local Group Policy Editor
Start-Process "gpedit.msc"

# Wait for the MMC process to launch
Add-Type -AssemblyName System.Windows.Forms

# Check if the process is running
while (-not (Get-Process "mmc" -ErrorAction SilentlyContinue)) {
    Start-Sleep -Milliseconds 500
}

# Wait for the Local Group Policy Editor to launch
Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Seconds 3

# Navigation in Local Group Policy Editor
1..8 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 500
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }
[System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")
Start-Sleep -Milliseconds 500
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }

# Wait for 0.5 seconds
Start-Sleep -Seconds 1

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")

Start-Sleep -Seconds 1

1..3 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Wait for 1 second
Start-Sleep -Seconds 2

# Tab 2 times
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{TAB}") }

Start-Sleep -Milliseconds 500

# Press Up arrow key
[System.Windows.Forms.SendKeys]::SendWait("{UP}")

# Press Enter
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Start-Sleep -Seconds 1 

# Press Alt + F4 to close Local Group Policy Editor
[System.Windows.Forms.SendKeys]::SendWait("%{F4}")

# Wait for 2 second
Start-Sleep -Seconds 2

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

# Restart Explorer
taskkill /f /im explorer.exe
start explorer.exe
