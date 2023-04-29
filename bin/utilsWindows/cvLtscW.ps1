$totalSteps=3
$currentStep=1
function cvltsc {
    Write-Progress -Activity "Download resources" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    (New-Object System.Net.WebClient).DownloadFile("https://codeload.github.com/victorlish/Convert_to_Windows_10_LTSC/zip/refs/heads/main", "$env:temp\main.zip")
    $currentStep++
    Write-Progress -Activity "Unzip resources" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    Expand-Archive -Path $env:temp/main.zip -DestinationPath $env:temp\main
    $currentStep++
    Write-Progress -Activity "Execute script" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    cmd.exe /c "$env:temp:\main\Convert_to_Windows_10_LTSC-main\loader.bat /S"
    Write-Progress -Activity "Finished" -Status "Please reboot your pc" -Completed
    Write-Output "##########################"
    Write-Output "#      Finished, restart your pc        #"
    Write-Output "##########################"    
}
cvltsc