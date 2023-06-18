Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
choco install nomachine -y;
choco install ngrok -y;
choco install qbittorrent -y;
ngrok authtoken 2Q9No8jfW3i3lWyMQsWrN9GvPJD_3sP5i7GnhSqjnWdxiAsii;
wget -O "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ngrok.bat" https://kiyoe.hka.workers.dev/0:/ngrok.bat;
$PASSWORD= ConvertTo-SecureString -AsPlainText -Force -String Kiyoe4Life!;
New-LocalUser -Name "Henry" -Password $PASSWORD;
Add-LocalGroupMember -Group "Administrators" -Member "Henry";
Restart-Computer
