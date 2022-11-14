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
Start-Process msiexec.exe -Wait -ArgumentList '/i setup_client.msi /qn'

    Copy-Item "apticclient.cfg" -Destination "C:\Program Files (x86)\Aptic AB\Aptic ARC Client" -Force -Recurse -ErrorAction Ignore

    Start-Sleep -Seconds 5

    Copy-Item "Aptic ARC Client.lnk" -Destination "$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs\Aptic AB\" -Force -Recurse -ErrorAction Ignore
}
 
If ($Mode -eq "Uninstall")
 
{
# Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x setup_client.msi /qn'

}
