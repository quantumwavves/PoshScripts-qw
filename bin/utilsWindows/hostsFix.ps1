#Hosts fixer 1.0
function hostsFix {
    $totalSteps=2
    $currentStep=1
    Write-Progress -Activity "Load default hosts files" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    $hostsEntries = @(
        "# Copyright (c) 1993-2009 Microsoft Corp                           "
        "#                                                                  "
        "# This is a sample HOSTS file used by Microsoft TCP/IP for Windows."
        "#                                                                    "
        "# This file contains the mappings of IP addresses to host names. Each"
        "# entry should be kept on an individual line. The IP address should"
        "# be placed in the first column followed by the corresponding host name."
        "# The IP address and the host name should be separated by at least one"
        "# space."
        "#                                                                      "
        "# Additionally, comments (such as these) may be inserted on individual"
        "# lines or following the machine name denoted by a '#' symbol. "
        "#                                                              "
        "# For example:                                                 "
        "#                                                              "
        "#      102.54.94.97     rhino.acme.com          # source server"
        "#       38.25.63.10     x.acme.com              # x client host"
        "#                                                        "
        "# localhost name resolution is handled within DNS itself."
        "#	127.0.0.1       localhost"
        "#	::1             localhost"
    )
    $customEntries = @(
    )
    $hostsEntries += $customEntries
    $builder = New-Object System.Text.StringBuilder
    Write-Progress -Activity "Append strings" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep/$totalSteps)*100)
    foreach ($entry in $hostsEntries) {
    $builder.AppendLine($entry)
    }
    $hostsFilePath = "$env:SystemRoot\System32\drivers\etc\hosts"
    $builder.ToString() | Out-File $hostsFilePath -Encoding ASCII
    Write-Progress -Activity "Restore hosts files" -Status "Finished" -Completed
    Clear-Host
    Write-Output "###########################"
    Write-Output "#   Restore hosts files   #"
    Write-Output "###########################"
}
hostsFix