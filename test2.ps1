# Function to display the menu
function Show-Menu {
    Clear-Host
    Write-Host "=============================================="
    Write-Host "      Choose an option to copy to clipboard"
    Write-Host "             (Press X to close)"
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

    # Return to exit the current function
    return
}
else {
    Write-Host "Invalid input. Please enter a valid number or 'x' to quit." -ForegroundColor Red
}
