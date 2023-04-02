function rustdeskSetup {
    #Download rustdesk
    (New-Object System.Net.WebClient).DownloadFile("https://github.com/rustdesk/rustdesk/releases/download/1.1.9/rustdesk-1.1.9-windows_x64.zip", "$env:temp\rustdesk.zip")
    #Installing Rustdesk
    Expand-Archive -Path $env:temp/rustdesk.zip -DestinationPath $env:temp\rustdesk
    cmd.exe /c "$env:temp\rustdesk\rustdesk-1.1.9-putes.exe --silent-install"
    Write-Output "Finish"
}
rustdeskSetup