# Step 1: Open Local Group Policy Editor
Start-Process "gpedit.msc"

# Wait for the Local Group Policy Editor to launch
Add-Type -AssemblyName System.Windows.Forms
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

Start-Sleep -Milliseconds 500

# Press Up arrow key
[System.Windows.Forms.SendKeys]::SendWait("{UP}")

# Press Enter
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

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