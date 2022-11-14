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

cd $PSScriptRoot

If ($Mode -eq "Install")
 
{
# Installerar...
Start-Process "APRO20.0\Adobe Acrobat\Setup.exe" -Wait -ArgumentList '/sl "1053" /sALL'
 
}
 
If ($Mode -eq "Uninstall")
 
{
# Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x "APRO20.0\Adobe Acrobat\AcroPro.msi" /qn'
 
}

