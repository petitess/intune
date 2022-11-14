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


If ($Mode -eq "Install")
{
    # Installerar...
    Start-Process msiexec.exe -Wait -ArgumentList '/i ManagementClientSetup.msi /qn'

    Copy-Item "Visma.Services.UserDirectory.Client.Application.exe.config" -Destination "C:\Program Files (x86)\Visma\UserDirectory\Client" -Force -Recurse -ErrorAction Ignore

}
 
If ($Mode -eq "Uninstall")
{
    # Avinstallerar...
    Start-Process msiexec.exe -Wait -ArgumentList '/x ManagementClientSetup.msi /qn'

}
