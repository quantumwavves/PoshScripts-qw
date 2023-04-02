(New-Object System.Net.WebClient).DownloadFile("https://ftp.nluug.nl/pub/games/PC/guru3d/ddu/[Guru3D.com]-DDU.zip", "$env:temp\DDU.zip")
Expand-Archive -Path $env:temp/DDU.zip -DestinationPath $env:temp\DDU
cmd.exe /c "$env:temp\DDU\DDU^ v18.0.6.0.exe /S /qn/v"
rmdir $env:temp\DDU.zip
& "C:\Program Files (x86)\Display Driver Uninstaller\Display Driver Uninstaller.exe"
