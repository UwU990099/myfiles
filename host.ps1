# Specify the path to the registry setting for desktop wallpaper
$wallpaperRegistryPath = "HKCU\Software\Policies\Microsoft\Windows\Personalization"

# Specify the name for the "desktop wallpaper" policy
$wallpaperValueName = "Wallpaper"

# Remove the desktop wallpaper policy by setting it to $null
Set-GPRegistryValue -Key $wallpaperRegistryPath -ValueName $wallpaperValueName -Type String -Value $null

# Specify the path to the registry setting for hiding the notification area
$notificationAreaRegistryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# Specify the name for the "hide the notification area" policy
$notificationAreaValueName = "NoTrayItemsDisplay"

# Set the "hide the notification area" policy to 0 to disable it
Set-GPRegistryValue -Key $notificationAreaRegistryPath -ValueName $notificationAreaValueName -Type DWORD -Value 0

# Stop the Windows Explorer process
Stop-Process -Name explorer -Force

# Start the Windows Explorer process
Start-Process explorer

# Download Ngrok
Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip"

# Create directory
New-Item -ItemType Directory -Path "C:\ngrok" -Force

# Extract ngrok.zip to C:\ngrok
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force

# Set ngrok authtoken
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu" -Wait

# Create or modify user (change password)
net user Administrator HenryRH9!

# Run ngrok with specified parameters
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389" -Wait
