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

# Close window
exit
