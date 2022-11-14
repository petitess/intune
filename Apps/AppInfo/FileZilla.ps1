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
Start-Process "FileZilla_3.57.0_win64-setup.exe" -Wait -ArgumentList '/install /quiet /norestart'

Copy-Item "fzdefaults.xml" -Destination "C:\Program Files\FileZilla FTP Client" -Force -Recurse -ErrorAction Ignore
 
}
 
If ($Mode -eq "Uninstall")
{
# Avinstallerar...
Start-Process "$Env:Programfiles\FileZilla FTP Client\uninstall.exe" -Wait -ArgumentList '/S'
#Remove Directory
Remove-Item "$Env:Programfiles\FileZilla FTP Client" -Recurse -Force
}

