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
# Installerar InCopy CC...
Start-Process msiexec.exe -Wait -ArgumentList '/i Build\CreativeCloud_InCopy.msi /quiet /norestart'
 
}
 
If ($Mode -eq "Uninstall")
 
{
 # Avinstallerar InCopy CC...
Start-Process msiexec.exe -Wait -ArgumentList '/x Build\CreativeCloud_InCopy.msi /quiet /norestart'
 
}
