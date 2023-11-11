wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip "C:\ngrok.zip"
mkdir "C:\ngrok"
expand -r C:\ngrok.zip C:\ngrok
C:\ngrok\ngrok.exe authtoken 2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu
net user Administrator HenryRH9!
C:\ngrok\ngrok.exe tcp --region ap 3389
