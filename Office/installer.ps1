# Hide progress bar
$ProgressPreference = 'SilentlyContinue'

Write-Host "Downloading offline installer"
# Download setup
Invoke-WebRequest -Uri "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/O365ProPlusRetail.img" -outfile "C:\Users\Administrator\Downloads\O365ProPlusRetail.img"

# Provide the path to your image file
$imagePath = "C:\Users\Administrator\Downloads\O365ProPlusRetail.img"

# Mount the image
Mount-DiskImage -ImagePath $imagePath

# Get the mounted disk
$mountedDisk = Get-DiskImage -ImagePath $imagePath | Get-Volume

# Change the PowerShell directory to the mounted drive
Set-Location -Path "$($mountedDisk.DriveLetter):"

# Run setup.exe using Start-Process
Start-Process -FilePath "setup.exe"

Read-Host "Press anything after the installation is finished"

# Dismount the image when done
Dismount-DiskImage -ImagePath $imagePath

Remove-Item -Path $imagePath -Force

irm https://massgrave.dev/get | iex
