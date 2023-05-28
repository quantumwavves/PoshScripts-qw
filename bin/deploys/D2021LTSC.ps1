function 2021Deploy {
    #Global variables
    $totalSteps=7
    $currentStep=1
    $officeVersion="2021 LTSC"
    $DownloadUrl="https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_16327-20214.exe" 
    $xml="https://raw.githubusercontent.com/quantumwavves/PoshScripts-qw/master/resources/OfficeDeploy/2021LTSC.xml"
    $mirrorUrl="https://media.githubusercontent.com/media/quantumwavves/PoshScripts-qw/master/resources/Executables/officedeploymenttool_16327-20214.exe"
    #Download developement tool
    Write-Progress -Activity "Download  development deploy tool $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
        $HTTP_Request = [System.Net.WebRequest]::Create($DownloadUrl)
        $HTTP_Response = $HTTP_Request.GetResponse()
        $HTTP_Status = [int]$HTTP_Response.StatusCode
        if($HTTP_Status -eq "200"){
            Write-Output "Status : $HTTP_Status. The download has started..."
            (New-Object System.Net.WebClient).DownloadFile($DownloadUrl, "$env:temp\officeDeploy.exe")
            Write-Output "Complete download."
        }
        else{
            Write-Output "Status : $HTTP_Status. Error connecting to the server, starting the download from the mirror..."
            (New-Object System.Net.WebClient).DownloadFile($mirrorUrl, "$env:temp\officeDeploy.exe")
            Write-Output "Comparing hashes"
            $knowHash="D84ECE99AAC1171A3AEF0B39E9673EFA3F4D2532163A2D671D8AC0245A0F16B8"
            $srcHash = Get-FileHash $env:temp\officeDeploy.exe -Algorithm "SHA256" 
            if ($knowHash -eq $srcHash.Hash){
                Write-Output "Hash status : OK"
            }else {
                Write-Error "Hash status : hashes are not equal"
                Remove-Item "$env:temp\officeDeploy.exe" -Force
            }
        }
    $currentStep++
    #Download personal XML
    Write-Progress -Activity "Getting custom xml configuration $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    (New-Object System.Net.WebClient).DownloadFile($xml, "$env:temp\2021LTSC.xml")
    Start-Sleep -Seconds 3
    $currentStep++
     #Status file health
     Write-Progress -Activity "Verifying files integrity $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
     Write-Output "Verifying files integrity..."
     if (Test-Path -Path "$env:temp\officeDeploy.exe") {
         Write-Output "Developement tool integrity status : OK"
     }else{
         Write-Output "Developement tool integrity status : Error source not found"
     }
     if (Test-Path -Path "$env:temp\2021LTSC.xml"){
        Write-Output "XML file configuration integrity status : OK"
     }else{
        Write-Output "XML file configuration integrity status : Error source not found"
     }
     $currentStep++
       #Unzip requiered files
    Write-Progress -Activity "Unzip files $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    if (Test-Path "$env:temp\deploy" -PathType Container) {
        Remove-Item "$env:temp\deploy" -Recurse -Force
    } else {
        New-Item -Path "$env:temp" -Name "deploy" -ItemType "directory" | Out-Null
    }
    cmd.exe /c "$env:temp\officeDeploy.exe /quiet /extract:$env:temp\deploy"
    $currentStep++
    #Deploy Office 2021 LTSC version
    Write-Progress -Activity "Deploying office $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    cmd.exe /c "$env:temp\deploy\setup.exe /configure $env:temp\2021LTSC.xml"
    $currentStep++
    #Cleaning temp files
    Write-Progress -Activity "Cleaning temp files $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    Remove-Item "$env:temp\deploy" -Recurse -Force
    Remove-Item "$env:temp\officeDeploy.exe" -Force
    Remove-Item "$env:temp\2021LTSC.xml" -Force
    #Finished deploy
    Write-Output "Deploy status : Completed"
    $currentStep++
    #Act Key management server
    Write-Progress -Activity "Activate $officeVersion" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    Start-Sleep -Seconds 2
    AMSO
    Write-Progress -Activity "Finished installation $officeVersion" -Status "Installation complete" -Completed
}
function AMSO {
    Set-Location 'C:\Program Files\Microsoft Office\Office16\' 
    $licenseFiles = Get-ChildItem -Path "..\root\Licenses16\ProPlus2021VL*.xrm-ms" -File
    foreach ($file in $licenseFiles) {
        $licensePath = $file.FullName
        & cscript.exe //nologo //B ospp.vbs /inslic:"$licensePath"
    }
    & cscript.exe //nologo //B ospp.vbs /setprt:1688
    & cscript.exe //nologo //B ospp.vbs /unpkey:6F7TH
    & cscript.exe //nologo //B ospp.vbs /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH
    & cscript.exe //nologo //B ospp.vbs /sethst:e8.us.to
    & cscript.exe //nologo //B ospp.vbs /act
    Write-Output "Activation completed"
    Set-Location "C:\Windows\system32"
}
2021Deploy