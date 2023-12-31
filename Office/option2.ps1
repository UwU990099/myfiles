# Define the URLs
$url1 = "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/O365ProPlusRetail.img"

# Open the URLs in Chrome
Start-Process "chrome.exe" -ArgumentList $url1

irm https://massgrave.dev/get | iex
