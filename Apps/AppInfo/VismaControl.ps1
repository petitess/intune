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
Start-Process msiexec.exe -Wait -ArgumentList '/i Installer.msi VI_CLIENT=1 VI_SERVER=1 VI_INSTALLER=0 VI_REPORTINGSERVER=SRV253014 VI_VUDSERVER=SRV253014 VI_REPORTINGSERVERPORT=50300 VI_SINGLESIGNONPORT=50100 VI_MANAGEMENTCLIENTPORT=50200 VI_REPORTSUSER=ad\svc-imadmin VI_SERVICEMACHINE=SRV253014 VI_PORT2=8002 VI_INTERNETAVAILABLE=True /qn'

Start-Process msiexec.exe -Wait -ArgumentList '/i VismaRegistry.msi /qn'

$SourceFile="Visma Control 12.lnk" 
$Startmenu="$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs\Visma Control 12"
$Desktop=[Environment]::GetFolderPath("CommonDesktopDirectory")
Copy-Item $SourceFile -Destination $Startmenu -Recurse -Force -ErrorAction Ignore
Copy-Item $SourceFile -Destination $Desktop -Recurse -Force -ErrorAction Ignore

}
 
If ($Mode -eq "Uninstall")
 
{
# Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x Installer.msi /qn'

}
