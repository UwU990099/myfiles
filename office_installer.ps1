$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://officecdn.microsoft.com/pr/wsus/setup.exe" -OutFile "C:\setup.exe"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/Configuration.xml" -OutFile "C:\Configuration.xml"
Set-Location -Path 'C:\'
Start-Process -FilePath 'setup.exe' -ArgumentList '/configure', 'Configuration.xml'
exit
