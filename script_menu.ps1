

# Function to display the menu
function Show-Menu {
    Clear-Host
    Write-Host "=============================================="
    Write-Host "          Choose a script to execute"
	Write-Host "             (Press X to close)"
    Write-Host "=============================================="
	Write-Host ""
    $index = 1
    $scriptList | ForEach-Object {
        Write-Host ("{0,3}. {1,-20}" -f $index, $_.Name) -ForegroundColor Green
        $index++
    }
}

# List of script information (Name and URL)
$scriptList = @(
    @{
        Name = "Start RDP"
        Url = "https://raw.githubusercontent.com/UwU990099/myfiles/main/host.ps1"
    },
    @{
        Name = "Change Wallpaper"
        Url = "https://raw.githubusercontent.com/UwU990099/myfiles/main/Change%20Wallpaper.ps1"
    },
    @{
        Name = "Install Office 365"
        Url = "https://raw.githubusercontent.com/UwU990099/myfiles/main/Office/installer.ps1"
    },
    @{
        Name = "Install Apps"
        Url = "https://raw.githubusercontent.com/UwU990099/myfiles/main/apps_install.ps1"
    }
)

# Main loop
while ($true) {
    # Display the menu
    Show-Menu

    # Get user input without requiring Enter
    $choice = $host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

    # Check if the user wants to quit
    if ($choice.Character -eq 'x') {
        break
    }

    # Validate user input
    $selectedScript = [int]::Parse($choice.Character)
    if ($selectedScript -ge 1 -and $selectedScript -le $scriptList.Count) {
	
	        Clear-Host
        # Execute the chosen script
        $chosenScript = $scriptList[$selectedScript - 1]
        irm $chosenScript['Url'] | iex
		
    }
    else {
        Write-Host "Invalid input. Please enter a valid number or 'q' to quit." -ForegroundColor Red
    }

    # Pause for a moment to display the result
    Start-Sleep -Seconds 1
}
