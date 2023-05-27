function 2021Deploy {
    $totalSteps=5
    $currentStep=1
    $officeVersion="2021 LTSC"
    $DownloadUrl="https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_16327-20214.exe"
    $xml="https://raw.githubusercontent.com/quantumwavves/PoshScripts-qw/master/resources/OfficeDeploy/2021LTSC.xml"
    $mirrorUrl="https://media.githubusercontent.com/media/quantumwavves/PoshScripts-qw/master/resources/Executables/officedeploymenttool_16327-20214.exe"
    #Download deploy tool
    Write-Progress -Activity "Download  development deploy tool $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    try{
        $response=Invoke-WebRequest -Uri $DownloadUrl -Method Head
        if($response.StatusCode -eq 200){
            (New-Object System.Net.WebClient).DownloadFile($DownloadUrl, "$env:temp\officeDeploy.exe")
        } 
        if ($response.StatusCode -ne 200) {
            (New-Object System.Net.WebClient).DownloadFile($mirrorUrl, "$env:temp\officeDeploy.exe")
            #Verifying hash
            $knowHash="7678BA243F284D280396F889C1FB2E8854D1EC30"
            $GetHash = Get-FileHash $env:temp\officeDeploy.exe -Algorithm SHA1
            if ($GetHash.Hash -eq $knowHash.Split(": ")[1]) {
            }
        }
    } catch {}
    $currentStep++
    #Unzip requiered files
    Write-Progress -Activity "Unzip files $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    if (Test-Path "$env:temp\deploy" -PathType Container) {
        Remove-Item "$env:temp\deploy" -Recurse -Force
    } else {
        New-Item -Path "$env:temp" -Name "deploy" -ItemType "directory" | Out-Null
    }
    . $env:temp\officeDeploy.exe /quiet /extract:$env:temp\deploy
    $currentStep++
    #Download personal XML
    Write-Progress -Activity "Getting custom xml configuration $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    (New-Object System.Net.WebClient).DownloadFile($xml, "$env:temp\deploy\2021LTSC.xml")
    Start-Sleep -Seconds 3
    $currentStep++
    #Deploy Office 2021 LTSC version
    Write-Progress -Activity "Deploying office $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    cmd.exe /c "$env:temp\deploy\setup.exe /configure $env:temp\deploy\2021LTSC.xml"
    $currentStep++
    #Cleaning temp files
    Write-Progress -Activity "Cleaning temp files $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    Remove-Item "$env:temp\deploy" -Recurse -Force
    Remove-Item "$env:temp\officeDeploy.exe" -Force
    #Finished deploy
    Write-Progress -Activity "Finished installation $officeVersion" -Status "Installation complete" -Completed
    Write-Output "Finished deploy"
}
2021Deploy