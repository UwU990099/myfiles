# Hide progress bar
$ProgressPreference = 'SilentlyContinue'

# Download setup
Invoke-WebRequest -Uri "https://officecdn.microsoft.com/pr/wsus/setup.exe" -outfile "c:\setup.exe"

# Download config
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/Configuration.xml" -outfile "C:\Configuration.xml"

# Install
Set-Location -Path 'C:\'
Start-Process -FilePath 'setup.exe' -ArgumentList '/configure', 'Configuration.xml' -Wait
