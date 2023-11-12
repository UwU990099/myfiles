$downloadUrl = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"
$savePath = [System.IO.Path]::Combine([System.IO.Path]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments), "Downloads\OfficeSetup.exe")

# Create a WebClient object
$webClient = New-Object System.Net.WebClient

# Download the file
$webClient.DownloadFile($downloadUrl, $savePath)

# Start the setup and wait for it to complete
$setupProcess = Start-Process -FilePath $savePath -PassThru
$setupProcess.WaitForExit()

# Run the additional command after setup is complete
if ($setupProcess.ExitCode -eq 0) {
    Write-Host "Setup completed successfully. Running additional command..."
    Invoke-Expression (Invoke-RestMethod -Uri "https://massgrave.dev/get")
    Write-Host "Additional command executed."
} else {
    Write-Host "Setup encountered an error. Additional command not executed."
}

Write-Host "Script complete."
