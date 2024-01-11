# Hiding download process bar
$ProgressPreference = 'SilentlyContinue'
$currentUsername = $env:USERNAME

# Installing Chocolatey + Apps
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install internet-download-manager -y --ignore-checksums
choco install winrar -y
choco install telegram -y

# Installing Ditto
Invoke-WebRequest -Uri "https://github.com/sabrogden/Ditto/releases/download/3.24.246.0/DittoSetup_64bit_3_24_246_0.exe" -OutFile "C:\Users\$currentUsername\Downloads\DittoSetup_64bit_3_24_246_0.exe"
Start-Process -FilePath "C:\Users\$currentUsername\Downloads\DittoSetup_64bit_3_24_246_0.exe" -ArgumentList "/Silent" -Wait
rm "C:\Users\$currentUsername\Downloads\DittoSetup_64bit_3_24_246_0.exe" -Force

# Installing WizTree
Invoke-WebRequest -Uri "https://diskanalyzer.com/files/wiztree_4_16_setup.exe" -OutFile "C:\Users\$currentUsername\Downloads\wiztree_4_16_setup.exe"
Start-Process -FilePath "C:\Users\$currentUsername\Downloads\wiztree_4_16_setup.exe" -ArgumentList "/Silent" -Wait
rm "C:\Users\$currentUsername\Downloads\wiztree_4_16_setup.exe" -Force
rm "C:\Users\$currentUsername\Desktop\WizTree.lnk" -Force

# Installing MacroRecorder
Invoke-WebRequest -Uri "https://static.jitbit.com/mr/MacroRecorderSetup.exe" -OutFile "C:\Users\$currentUsername\Downloads\MacroRecorderSetup.exe"
Start-Process -FilePath "C:\Users\$currentUsername\Downloads\MacroRecorderSetup.exe" -ArgumentList "/Silent" -Wait
rm "C:\Users\$currentUsername\Downloads\MacroRecorderSetup.exe" -force

# Installing LosslessCut
New-Item -ItemType Directory -Path "C:\LosslessCut" -Force
Invoke-WebRequest -Uri "https://github.com/mifi/lossless-cut/releases/latest/download/LosslessCut-win-x64.7z" -OutFile "C:\Users\$currentUsername\Downloads\LosslessCut-win-x64.7z"
while ((Test-Path "C:\Users\$currentUsername\Downloads\LosslessCut-win-x64.7z.part")) {
    Start-Sleep -Seconds 1
}
$winrarProcess = Start-Process -FilePath "C:\Program Files\WinRAR\WinRAR.exe" -ArgumentList "x", "`"C:\Users\$currentUsername\Downloads\LosslessCut-win-x64.7z`"", "`"C:\LosslessCut`"" -PassThru
while (!$winrarProcess.HasExited) {
    Start-Sleep -Seconds 1
}
Remove-Item "C:\Users\$currentUsername\Downloads\LosslessCut-win-x64.7z" -Force
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("C:\Users\$currentUsername\Desktop\LosslessCut.lnk")
$shortcut.TargetPath = "C:\LosslessCut\LosslessCut.exe"
$shortcut.Save()

Start-Process "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
