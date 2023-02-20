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

#Detection method: File or folder exists - PaperCut.txt

$fileToDetect = "PaperCut.txt"

If ($Mode -eq "Install")
 
{
$Printer = Get-CimInstance -Class Win32_Printer | where {$_.Name -match "PaperCut"}
Invoke-CimMethod -InputObject $Printer -MethodName SetDefaultPrinter 

New-Item -Path "C:\Users" -Name $fileToDetect -ItemType File `
-Value "PaperCut Printer as default printer. Den filen skapades av Intune." `
-Confirm:$false
}
 
If ($Mode -eq "Uninstall")
 
{
 Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows' -Name 'LegacyDefaultPrinterMode' -value '0'
 Remove-Item -Path "C:\Users\$fileToDetect"
}