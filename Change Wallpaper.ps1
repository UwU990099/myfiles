# Step 1: Open Local Group Policy Editor
Start-Process "gpedit.msc"

# Wait for the Local Group Policy Editor to launch
Start-Sleep -Seconds 5

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

$ProgressPreference = 'SilentlyContinue'

# Set your GitHub repository information
$repoOwner = "UwU990099"
$repoName = "myfiles"
$branch = "main"  # or the branch you want to download from
$folderPath = "wallpapers"  # path to the folder in the repository

# Construct the GitHub API URL to get the contents of the folder
$uri = "https://api.github.com/repos/$repoOwner/$repoName/contents/$folderPath"
$uri += "?ref=$branch"

# Make a request to the GitHub API to get the list of files in the folder
$response = Invoke-RestMethod -Uri $uri -Method Get

# Loop through each file in the response and download it
foreach ($file in $response) {
    $fileUrl = $file.download_url
    $fileName = $file.name
    $outputPath = "C:\Users\Administrator\Pictures\$fileName"  # Specify your desired download location

    Invoke-WebRequest -Uri $fileUrl -OutFile $outputPath
}

Start-Sleep -Seconds 1


Add-Type -AssemblyName System.Windows.Forms

# Open personalize settings
Start-Process "ms-settings:personalization-background"

# Wait for the window to open (adjust the sleep duration if needed)
Start-Sleep -Seconds 2

# Send keys
[System.Windows.Forms.SendKeys]::SendWait("{TAB 2}")
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("{DOWN 2}")
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("{TAB 3}")
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("{UP}")
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait(" ")
Start-Sleep -Milliseconds 500

# Alt + F4
[System.Windows.Forms.SendKeys]::SendWait("%{F4}")







# Specify the path to the default Windows 10 wallpaper
# $wallpaperPath = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"


# Set the wallpaper using the SystemParametersInfo function
# Add-Type -TypeDefinition @"
#    using System;
#    using System.Runtime.InteropServices;
#
#    public class Wallpaper {
#        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
#        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
#    }
# "@

# [Wallpaper]::SystemParametersInfo(0x0014, 0, $wallpaperPath, 0x01)

# Restart Explorer
Stop-Process -Name explorer -Force
