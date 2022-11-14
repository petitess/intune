Param(
[Parameter(Mandatory=$true)]
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
    msiexec /i "TeamViewer_Host.msi" /qn CUSTOMCONFIGID=6pme3jj APITOKEN=11735722-6LPySrOmzaHRSaQP7yBH ASSIGNMENTOPTIONS="--reassign"
}
 
If ($Mode -eq "Uninstall")
{
    # Avinstallerar...
    msiexec /x "{1AA5234A-7DC7-4851-837C-68436892D2C6}" /q
}
