[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# Make folders
New-Item -ItemType Directory -Path "C:\LGPO" -Force
New-Item -ItemType Directory -Path "C:\gp" -Force

# Download LGPO
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/LGPO.exe" -OutFile "C:\LGPO\LGPO.exe"

# Download GP Backup
Invoke-WebRequest -Uri "https://github.com/UwU990099/myfiles/raw/main/gp.zip" -OutFile "C:\gp.zip"

# Extract GP Backup
Expand-Archive -Path "C:\gp.zip" -DestinationPath "C:\gp" -Force

# Import GP
& "C:\LGPO\LGPO.exe" /g "C:\gp"

# Download Ngrok
Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip"

# Create directory
New-Item -ItemType Directory -Path "C:\ngrok" -Force

# Extract ngrok.zip to C:\ngrok
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force

# Set ngrok authtoken
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu" -Wait

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/ngrok_startup.bat" -OutFile "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ngrok_startup.bat"

# Create or modify user (change password)
net user Administrator HenryRH9!

# Run ngrok with specified parameters
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389"

# Close window
exit
