$ProgressPreference = 'SilentlyContinue'

# Set your GitHub repository information
$repoOwner = "UwU990099"
$repoName = "myfiles"
$branch = "main"  # or the branch you want to download from
$folderPath = "wallpapers"  # path to the folder in the repository

# Construct the GitHub API URL to get the contents of the folder
$uri = "https://api.github.com/repos/$repoOwner/$repoName/contents/$folderPath"
$uri += "?ref=$branch"

# Make a request to the GitHub API to get the list of files in the folder
$response = Invoke-RestMethod -Uri $uri -Method Get

# Loop through each file in the response and download it
foreach ($file in $response) {
    $fileUrl = $file.download_url
    $fileName = $file.name
    $outputPath = "C:\Users\Administrator\Downloads\$fileName"  # Specify your desired download location

    Invoke-WebRequest -Uri $fileUrl -OutFile $outputPath
}
