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
Start-Process msiexec.exe -Wait -ArgumentList '/i PronestorOutlook2016Setup.msi /qn /norestart'
 
}
 
If ($Mode -eq "Uninstall")
 
{
 # Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x PronestorOutlook2016Setup.msi /qn /norestart'
 
}
