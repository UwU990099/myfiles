# Deleting Edge icon
rm "C:\Users\Administrator\Desktop\Microsoft Edge.lnk"

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
$url1 = "https://microsoftedge.microsoft.com/addons/detail/urban-vpn-proxy/nimlmejbmnecnaghgmbahmbaddhjbecg"
$url2 = "https://microsoftedge.microsoft.com/addons/detail/auto-refresh-plus-page-/oiecibnnapjeijccpmhonpooadjpcmnk"
$url3 = "https://www.coursera.org/login"
$url4 = "https://justpaste.it/hka"

# Open the URLs in Chrome
Start-Process "msedge.exe" -ArgumentList $url1
Start-Process "msedge.exe" -ArgumentList $url2
Start-Process "msedge.exe" -ArgumentList $url3
Start-Process "msedge.exe" -ArgumentList $url4
