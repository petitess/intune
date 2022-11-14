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
Start-Process msiexec.exe -Wait -ArgumentList '/i Install\ClientDocument.msi /qn REINSTALLMODE=a'
 
}
 
If ($Mode -eq "Uninstall")
 
{
 # Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x Install\ClientDocument.msi /qn'
 
}
