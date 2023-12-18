# Hide progress bar
$ProgressPreference = 'SilentlyContinue'

Write-Host "Downloading offline installer"

# Create a WebClient object
$webClient = New-Object System.Net.WebClient

# Set the proxy for the WebClient
$webClient.Proxy = [System.Net.WebRequest]::DefaultWebProxy
$webClient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials

# Download setup with -OutFile
$webClient.DownloadFile("https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/O365ProPlusRetail.img", "C:\Users\Administrator\Downloads\O365ProPlusRetail.img")

# Check if the file exists
$imagePath = "C:\Users\Administrator\Downloads\O365ProPlusRetail.img"
if (Test-Path $imagePath) {
    Write-Host "Download successful. Proceeding with the installation."

    # Mount the image
    Mount-DiskImage -ImagePath $imagePath

    # Get the mounted disk
    $mountedDisk = Get-DiskImage -ImagePath $imagePath | Get-Volume

    # Change the PowerShell directory to the mounted drive
    Set-Location -Path "$($mountedDisk.DriveLetter):"

    # Run setup.exe using Start-Process
    Start-Process -FilePath "setup.exe"

    Write-Host "Press anything after the installation is finished..."
    Read-Host

    # Dismount the image when done
    Dismount-DiskImage -ImagePath $imagePath

    Remove-Item -Path $imagePath -Force

    irm https://massgrave.dev/get | iex
} else {
    Write-Host "Failed to download the file. Please check the URL and try again."
}
