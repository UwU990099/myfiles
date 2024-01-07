# Step 1: Open Local Group Policy Editor
Start-Process "gpedit.msc"

# Wait for the Local Group Policy Editor to launch
Start-Sleep -Seconds 5
Add-Type -AssemblyName System.Windows.Forms

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

Write-Host "Press anything to continue..."
Read-Host


# Tab 2 times
# 1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{TAB}") }

# Start-Sleep -Milliseconds 500

# Press Up arrow key
# [System.Windows.Forms.SendKeys]::SendWait("{UP}")

# Press Enter
# [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Start-Sleep -Seconds 1 

# Press Alt + F4 to close Local Group Policy Editor
# [System.Windows.Forms.SendKeys]::SendWait("%{F4}")

# Wait for 2 second
# Start-Sleep -Seconds 2

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

# Get the current logged-in username
$currentUsername = $env:USERNAME

# Loop through each file in the response and download it
foreach ($file in $response) {
    $fileUrl = $file.download_url
    $fileName = $file.name
    $outputPath = "C:\Users\$currentUsername\Pictures\$fileName"  # Specify your desired download location

    Invoke-WebRequest -Uri $fileUrl -OutFile $outputPath
}

Start-Sleep -Seconds 1

Write-Host "Press anything to continue..."
Read-Host

# Restart Explorer
Stop-Process -Name explorer -Force

Start-Sleep -Seconds 2

# Open personalize settings
Start-Process "ms-settings:personalization-background"

Start-Sleep -Seconds 2

# Press Tab 2 times
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{TAB}") }
Start-Sleep -Milliseconds 500

# Press Down key 2 times
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{DOWN}") }
Start-Sleep -Milliseconds 500

# Press Tab 3 times
1..3 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{TAB}") }
Start-Sleep -Milliseconds 500

# Press Up key 2 times
1..2 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{UP}") }
Start-Sleep -Milliseconds 500

# Press Tab 1 time
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")

# Press Spacebar 1 time
[System.Windows.Forms.SendKeys]::SendWait(" ")
Start-Sleep -Milliseconds 500

# Press Alt + F4
[System.Windows.Forms.SendKeys]::SendWait("%{F4}")

