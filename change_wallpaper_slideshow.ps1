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
    $outputPath = "C:\Users\Administrator\Downloads\$fileName"  # Specify your desired download location

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
