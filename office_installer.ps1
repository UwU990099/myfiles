$ProgressPreference = 'SilentlyContinue'
$downloadUrl = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"
$savePath = Join-Path $env:USERPROFILE\Downloads "OfficeSetup.exe"

# Download the file
Invoke-WebRequest -Uri $downloadUrl -OutFile $savePath

# Start the setup and wait for it to complete
$setupProcess = Start-Process -FilePath $savePath -PassThru

# Run the additional command
Invoke-Expression (Invoke-RestMethod -Uri "https://massgrave.dev/get")
