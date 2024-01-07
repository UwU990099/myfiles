(Get-ItemProperty -path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome').version | ForEach-Object {& ${env:ProgramFiles(x86)}\Google\Chrome\Application\$_\Installer\setup.exe --uninstall --multi-install --chrome --system-level --force-uninstall}

# Create a new local user
$Username = "Austin"
$Password = ConvertTo-SecureString "SKYF@111" -AsPlainText -Force
New-LocalUser -Name $Username -Password $Password -PasswordNeverExpires:$true

# Add the user to the administrators group
Add-LocalGroupMember -Group "Administrators" -Member $Username

# Hiding download process bar and bypassing security protocols
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# Starting RDP tunnel
Write-Host "Starting RDP tunnel"
Invoke-WebRequest -Uri "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip" -OutFile "C:\ngrok.zip" | Out-Null
New-Item -ItemType Directory -Path "C:\ngrok" -Force | Out-Null
Expand-Archive -Path "C:\ngrok.zip" -DestinationPath "C:\ngrok" -Force | Out-Null
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "authtoken", "2D87U3TUdDf9Nc8F4ONyfd171ws_2dVq19DckWJys62B4DMYu" -Wait | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/UwU990099/myfiles/main/ngrok_startup.bat" -OutFile "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ngrok_startup.bat" | Out-Null
Start-Process -FilePath "C:\ngrok\ngrok.exe" -ArgumentList "tcp", "--region", "ap", "3389"
Remove-Item -Path "C:\ngrok.zip" -Force 

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

# Enable task view button
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView"
$registryEntryName = "Enabled"
if (Test-Path -Path $registryPath) {
    $registryValue = Get-ItemProperty -Path $registryPath -Name $registryEntryName -ErrorAction SilentlyContinue
    if ($registryValue -ne $null) {
        # Remove the registry entry
        Remove-ItemProperty -Path $registryPath -Name $registryEntryName -Force
    } else {
    }
} else {
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowTaskViewButton -Type DWord -Value 1
Stop-Process -Name explorer -Force

# Open the URLs
$url1 = "https://chromewebstore.google.com/detail/urban-vpn-proxy/eppiocemhmnlbhjplcgkofciiegomcon"
$url2 = "https://chromewebstore.google.com/detail/auto-refresh-plus-page-mo/hgeljhfekpckiiplhkigfehkdpldcggm"
$url3 = "https://www.coursera.org/login"
$url4 = "https://justpaste.it/hka"

# Open the URLs in Chrome
Start-Process "chrome.exe" -ArgumentList $url1
Start-Process "chrome.exe" -ArgumentList $url2
Start-Process "chrome.exe" -ArgumentList $url3
Start-Process "chrome.exe" -ArgumentList $url4

# Freeing up space
Write-Host "Freeing up space"
Remove-Item -Path "C:\Program Files\RStudio" -Recurse -Force
Remove-Item -Path "C:\Program Files\LibreOffice" -Recurse -Force
Remove-Item -Path "C:\Users\Administrator\AppData\Local\Programs" -Recurse -Force
Remove-Item -Path "C:\Users\Administrator\AppData\Local\GitHubDesktop" -Recurse -Force
# Remove-Item -Path "C:\Program Files\Microsoft SQL Server" -Recurse -Force
Remove-Item -Path "C:\Program Files\Azure Data Studio" -Recurse -Force
Start-Process -FilePath "C:\Program Files\R\R-3.6.3\unins000.exe" -ArgumentList "/Silent"
Start-Process -FilePath "C:\Program Files\Git\unins000.exe" -ArgumentList "/Silent"
# Specify the path to the Firefox uninstaller executable
$uninstallerPath = "C:\Program Files\Mozilla Firefox\uninstall\helper.exe"

# Check if the uninstaller executable exists
if (Test-Path $uninstallerPath) {
    # Uninstall Firefox silently
    Start-Process -FilePath $uninstallerPath -ArgumentList "/S" -Wait
    Write-Host "Firefox has been uninstalled silently."
} else {
    Write-Host "Firefox uninstaller not found at the specified path."
}
Remove-Item -Path "C:\Ruby*" -Recurse -Force
