Param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Install", "Uninstall")]
    [String[]]
    $Mode
)

## För att installera:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Install 

## För att avinstallera:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Uninstall 


If ($Mode -eq "Install") {
    # Installerar...
    Start-Process msiexec.exe -Wait -ArgumentList '/i Installation\CaesarForOutlook.sv-se.msi /qn ALLUSERS="1" '
    Copy-Item "Installation\Default.config" -Destination "C:\Program Files (x86)\Caesar\Caesar for Outlook" -Force -Recurse -ErrorAction Ignore    
}
 
If ($Mode -eq "Uninstall") {
    # Avinstallerar...
    Start-Process msiexec.exe -Wait -ArgumentList '/x Installation\CaesarForOutlook.sv-se.msi /qn'

    # Get users
    $users = Get-ChildItem -Path "C:\Users"

    # Loop through users and delete the file
    $users | ForEach-Object {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Caesar" -Force -Recurse -ErrorAction Ignore
    }

}
