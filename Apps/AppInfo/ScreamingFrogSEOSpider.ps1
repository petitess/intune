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

#Detection method: File or folder exists

$fileToDetect = "v.18.1.txt"

If ($Mode -eq "Install")
 
{
# Installerar InCopy CC...
Start-Process "ScreamingFrogSEOSpider-18.1.exe" -ArgumentList "/S" -Wait

if (Test-Path -Path "C:\Program Files (x86)\Screaming Frog SEO Spider"){
New-Item -ItemType File -Path "C:\Program Files (x86)\Screaming Frog SEO Spider" -Name $fileToDetect

}else{
New-Item -ItemType Directory -Path "C:\Program Files\" -Name "Screaming Frog SEO Spider"
New-Item -ItemType File -Path "C:\Program Files (x86)\Screaming Frog SEO Spider" -Name $fileToDetect
}
}
 
If ($Mode -eq "Uninstall")
 
{
 # Avinstallerar InCopy CC...
Start-Process -FilePath "C:\Program Files (x86)\Screaming Frog SEO Spider\uninstall.exe" -ArgumentList "/S" -Wait
if (Test-Path -Path "C:\Program Files (x86)\Screaming Frog SEO Spider"){
Remove-Item -Path "C:\Program Files (x86)\Screaming Frog SEO Spider\$fileToDetect"
}
}