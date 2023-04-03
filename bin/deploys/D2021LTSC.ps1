function 2021Deploy {
    (New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_16130-20218.exe", "$env:temp\offiedeploy.exe")
    mkdir $env:temp\deploy
    .$env:temp\offiedeploy.exe /quiet /extract:$env:temp\deploy
    (New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/quantumwavves/PoshScripts-qw/master/resources/OfficeDeploy/2021LTSC.xml", "$env:temp\deploy\2021LTSC.xml")
    . $env:temp\deploy\setup.exe /configure $env:temp\deploy\2021LTSC.xml
    Write-Output "Finished deploy"
}
2021Deploy
