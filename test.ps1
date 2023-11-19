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

# Function to display the menu
function Show-Menu {
    Clear-Host
    Write-Host "=============================================="
    Write-Host "      Choose an option to copy to clipboard"
    Write-Host "=============================================="
    Write-Host ""
    $choices.GetEnumerator() | Sort-Object Key | ForEach-Object {
        Write-Host ("{0,3}. {1,-30}" -f $_.Key, $_.Value) -ForegroundColor Green
    }
}

# List of choices
$choices = @{
    1 = "ycxumqz@hldrive.com"
    2 = "woraw97154@eazenity.com"
}

# Display the menu
Show-Menu

# Get user input without requiring Enter
$choice = $host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

# Validate user input
$selectedChoice = [int]::Parse($choice.Character.ToString())
if ($choices.ContainsKey($selectedChoice)) {
    # Copy the selected text to the clipboard
    $choices[$selectedChoice] | Set-Clipboard

    Write-Host "Text '$($choices[$selectedChoice])' copied to the clipboard."

    # Pause for a moment to display the result
    Start-Sleep -Seconds 1
}
else {
    Write-Host "Invalid input. Please enter a valid number." -ForegroundColor Red
}
