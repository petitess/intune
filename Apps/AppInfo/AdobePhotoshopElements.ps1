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
Start-Process msiexec.exe -Wait -ArgumentList '/i Build\Adobe_Photoshop_Elements_15.0_x64_SV_1.0.msi /qn INSTALLLANGUAGE=sv_SE'
 
}
 
If ($Mode -eq "Uninstall")
 
{
 # Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x Build\Adobe_Photoshop_Elements_15.0_x64_SV_1.0.msi /qn NOT_STANDALONE=1'
 
}
