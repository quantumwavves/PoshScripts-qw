function options {
    Write-Host "#######################################"
    Write-Host "#             JAMSOA 2.0              #"
    Write-Host "#                                     #"
    Write-Host "#     1: Set your own KMS server      #"
    Write-Host "#     2: Default (e8.us.to)           #"
    Write-Host "#     3: Remove any KMS key           #"
    Write-Host "#                                     #"
    Write-Host "#######################################"
    Write-Host "                                       "
    $choise= Read-Host "Select option: "
    if($choise -eq "1"){
        $domain= Read-Host "Put your kms server: "
        Clear-Host
        JAMSOA
        }
    if($choise -eq "2"){JAMSOA}
    if($choise -eq "3"){keyRemover}    
}
function JAMSOA {
    $Folder = 'C:\Program Files\Microsoft Office\Office16\'
    if (Test-Path -Path $Folder) {
        Set-Location 'C:\Program Files\Microsoft Office\Office16\'
        $MSPath='C:\Program Files\Microsoft Office\Office16\'
    } else {
        Set-Location 'C:\Program Files (x86)\Microsoft Office\Office16'
        $MSPath='C:\Program Files (x86)\Microsoft Office\Office16'
    }
    $getLicenseName = cmd.exe /c "cscript ospp.vbs /dstatus" | Select-String 'License Name' 
    $desiredText = ($getLicenseName -split ',')[1] -replace 'VL_KMS_Client_AE| edition', ''
    $licenseName = $desiredText.Trim('')
    Write-Output "-> Office version: $licenseName"
    if($licenseName -eq "Office21ProPlus2021"){
        Write-Output "-> Installing licenses"
        $licenseFiles = Get-ChildItem -Path "..\root\Licenses16\ProPlus2021VL*.xrm-ms" -File
        foreach ($file in $licenseFiles) {
            $licensePath = $file.FullName
            & cscript.exe //nologo //B ospp.vbs /inslic:"$licensePath"
        }
        Write-Host "-> Setting the port"
        & cscript.exe //nologo //B ospp.vbs /setprt:1688
        Write-Host "-> Unpkey if available"
        & cscript.exe //nologo //B ospp.vbs /unpkey:6F7TH
        Write-Output "-> Adding serial key to office"
        & cscript.exe //nologo //B ospp.vbs /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH
        Write-Output "-> Connect with key management server..."
        if ($choise -eq 1) {& cscript.exe //nologo //B ospp.vbs /sethst:$domain}
        if ($choise -eq 2) {& cscript.exe //nologo //B ospp.vbs /sethst:e8.us.to}
        Write-Output "-> Activating office copy"
        & cscript.exe //nologo //B ospp.vbs /act
        Write-Output "-> Activation completed"
        Set-Location "C:\Windows\system32"
    }
    if($licenseName -eq "Office19ProPlus2019"){
        Write-Output "-> Installing licenses"
        $licenseFiles = Get-ChildItem -Path "..\root\Licenses16\ProPlus2019VL*.xrm-ms" -File
        foreach ($file in $licenseFiles) {
            $licensePath = $file.FullName
            & cscript.exe //nologo //B ospp.vbs /inslic:"$licensePath"
        }
        Write-Host "-> Setting the port"
        & cscript.exe //nologo //B ospp.vbs /setprt:1688
        Write-Host "-> Unpkey if available"
        & cscript.exe //nologo //B ospp.vbs /unpkey:6MWKP
        Write-Output "-> Adding serial key to office"
        & cscript.exe //nologo //B ospp.vbs /inpkey:NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP
        Write-Output "-> Conect with key management server..."
        if ($choise -eq 1) {& cscript.exe //nologo //B ospp.vbs /sethst:$domain}
        if ($choise -eq 2) {& cscript.exe //nologo //B ospp.vbs /sethst:e8.us.to}
        Write-Output "-> Activating office copy"
        & cscript.exe //nologo //B ospp.vbs /act
        Write-Output "-> Activation completed"
        Set-Location "C:\Windows\system32"
    } 
}
function keyRemover {
    $Folder = 'C:\Program Files\Microsoft Office\Office16\'
    if (Test-Path -Path $Folder) {
        Set-Location 'C:\Program Files\Microsoft Office\Office16\'
        $MSPath='C:\Program Files\Microsoft Office\Office16\'
    } else {
        Set-Location 'C:\Program Files (x86)\Microsoft Office\Office16'
        $MSPath='C:\Program Files (x86)\Microsoft Office\Office16'
    }
    $getLicenseName = cmd.exe /c "cscript ospp.vbs /dstatus" | Select-String 'License Name' 
    $desiredText = ($getLicenseName -split ',')[1] -replace 'VL_KMS_Client_AE| edition', ''
    $licenseName = $desiredText.Trim('')
    Write-Output "-> Office version: $licenseName"
    if ($licenseName -eq "Office21ProPlus2021"){
        Write-Output "Remove key from office"
        & cscript.exe //nologo //B ospp.vbs /unpkey:6F7TH
        Write-Output "The key was successfully removed"
    }
    if ($licenseName -eq "Office19ProPlus2019"){
        Write-Output "Remove key from office"
        & cscript.exe //nologo //B ospp.vbs /unpkey:6MWKP
        Write-Output "The key was successfully removed"
    }
}
options