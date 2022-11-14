Param(
[Parameter(Mandatory=$true)]
[ValidateSet("Install", "Uninstall")]
[String[]]
$Mode
)

## To install:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Install 

## To uninstall:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Uninstall 


If ($Mode -eq "Install")
 
{
# Installing...
Start-Process msiexec.exe -Wait -ArgumentList '/i 7z-x64.msi /qn /norestart ACCEPT_EULA=YES'
 
}
 
If ($Mode -eq "Uninstall")
 
{
 # Uninstalling...
Start-Process msiexec.exe -Wait -ArgumentList '/x 7z-x64.msi /qn /norestart'
 
}