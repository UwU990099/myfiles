# Registry path and entry name
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView"
$registryEntryName = "Enabled"

# Check if the registry entry exists before attempting to remove it
if (Test-Path -Path $registryPath) {
    $registryValue = Get-ItemProperty -Path $registryPath -Name $registryEntryName -ErrorAction SilentlyContinue
    if ($registryValue -ne $null) {
        # Remove the registry entry
        Remove-ItemProperty -Path $registryPath -Name $registryEntryName -Force
    } else {
    }
} else {
}

# Add registry entry
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowTaskViewButton -Type DWord -Value 1

# Restart Explorer
Stop-Process -Name explorer -Force

# Define the URLs
$url1 = "https://chromewebstore.google.com/detail/auto-refresh-plus-page-mo/hgeljhfekpckiiplhkigfehkdpldcggm?pli=1"
$url2 = "https://chromewebstore.google.com/detail/urban-vpn-proxy/eppiocemhmnlbhjplcgkofciiegomcon"
$url3 = "https://www.coursera.org/login"

# Open the URLs in Chrome
Start-Process "chrome.exe" -ArgumentList $url1
Start-Process "chrome.exe" -ArgumentList $url2
Start-Process "chrome.exe" -ArgumentList $url3
