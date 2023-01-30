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

#Detection method: File or folder exists - v.8.4.8.txt

$fileToDetect = "v.8.4.8.txt"

If ($Mode -eq "Install")
 
{
# Installerar InCopy CC...
Start-Process "npp.8.4.8.Installer.x64.exe" -ArgumentList "/S" -Wait

if (Test-Path -Path "C:\Program Files\Notepad++"){
New-Item -ItemType File -Path "C:\Program Files\Notepad++" -Name $fileToDetect

}else{
New-Item -ItemType Directory -Path "C:\Program Files\" -Name "Notepad++"
New-Item -ItemType File -Path "C:\Program Files\Notepad++" -Name $fileToDetect
}
}
 
If ($Mode -eq "Uninstall")
 
{
 # Avinstallerar InCopy CC...
Start-Process -FilePath "C:\Program Files\Notepad++\uninstall.exe" -ArgumentList "/S" -Wait
Remove-Item -Path "C:\Program Files\Notepad++\$fileToDetect"
}
