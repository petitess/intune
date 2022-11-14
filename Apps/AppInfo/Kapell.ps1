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
Start-Process msiexec.exe -Wait -ArgumentList '/i Kapell.msi /qn /norestart'


$SourceFolder="Öhrlings PricewaterhouseCoopers" 
$DestFolder1="C:\Users\Default\AppData\Roaming"
$DestFolder2=$env:ALLUSERSPROFILE
Copy-Item $SourceFolder -Destination $DestFolder1 -Recurse -Force -ErrorAction Ignore
Copy-Item $SourceFolder -Destination $DestFolder2 -Recurse -Force -ErrorAction Ignore

Remove-Item "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Kapell\Nyheter i Kapell 7.1b.lnk"


}
 
If ($Mode -eq "Uninstall")
 
{
# Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x Kapell.msi /qn /norestart'

Remove-Item "C:\Users\Default\AppData\Roaming\Öhrlings PricewaterhouseCoopers" -Recurse -Force -ErrorAction Ignore
Remove-Item "$env:ALLUSERSPROFILE\Öhrlings PricewaterhouseCoopers" -Recurse -Force -ErrorAction Ignore

}
