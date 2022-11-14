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
Start-Process "eFrontExcel\eFrontExcelSetup.exe" -Wait -ArgumentList '/install /quiet /norestart'


# Copy configurations to install folder
Copy-Item "eFrontExcel\FrontExcel64AddInPack.xll.config" -Destination "C:\Program Files (x86)\eFront\FrontExcel" -Force -Recurse -ErrorAction Ignore
Copy-Item "eFrontExcel\FrontExcelAddInPack.xll.config" -Destination "C:\Program Files (x86)\eFront\FrontExcel" -Force -Recurse -ErrorAction Ignore

}
 
If ($Mode -eq "Uninstall")
 
{
# Avinstallerar...
Start-Process "eFrontExcel\eFrontExcelSetup.exe" -Wait -ArgumentList '/uninstall /quiet /norestart'

# Remove directories
Remove-Item -Path "C:\Program Files\eFront\FrontExcel" -Recurse -Force

}
