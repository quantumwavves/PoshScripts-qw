##V.0.6

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Invoke-WebRequest -Uri "https://media.githubusercontent.com/media/quantumwavves/PoshScripts-qw/master/resources/Executables/gnupg-w32-2.3.8_20221013.exe" -OutFile "$env:temp\gnupg-w32-2.3.8_20221013.exe"
cmd.exe /c $env:temp\gnupg-w32-2.3.8_20221013.exe /S /V /QN
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/quantumwavves/PoshScripts-qw/master/resources/Binary/qwo.ps1.gpg" -OutFile "$env:temp\qwo.ps1.gpg"
& 'C:\Program Files (x86)\GnuPG\bin\gpg.exe' -d $env:temp\qwo.ps1.gpg >> $env:temp\qwo.ps1
. $env:temp\qwo.ps1
& 'C:\Program Files (x86)\GnuPG\gnupg-uninstall.exe' /S /V /QN
Remove-Item $env:appdata\gnupg -Recurse
Clear-History
Remove-Item (Get-PSReadlineOption).HistorySavePath
