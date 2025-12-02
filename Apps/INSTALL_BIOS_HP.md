### Install BIOS through Win32 App installer

Download exe file for your BIOS version

Extract sp123456.exe 

Put the content in a folder "G40110"

Prepare the app and powershell script by using the IntuneWinAppUtil.exe

Upload intunewin file in intune

##### Program
```s
Install command
powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Install 
Uninstall command
powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Uninstall 
Installation time required (mins)
60
Allow available uninstall
Yes
Install behavior
System
Device restart behavior
App install may force a device restart
```
##### Requirements
```s
Configure additional requirement rules
Requirement type
Registry
Key path
HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\BIOS
Value name
SystemProductName
Registry key requirement
String comparison
Operator
Equals
Value
HP Dragonfly 13.5 inch G4 Notebook PC
```
##### Detection rules
```s
Rule type
Registry
Key path
HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\BIOS
Value name
BIOSVersion
Detection method
String comparison
Operator
Equals
Value
V90 Ver. 01.10.00
```
##### Script
```pwsh
Param(
  [Parameter(Mandatory = $true)]
  [ValidateSet("Install", "Uninstall")]
  [String[]]
  $Mode
)

## För att installera:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Install 

## För att avinstallera:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Uninstall 

If ($Mode -eq "Install") {
  # Installerar...
  
  Copy-Item -Path "G40110" -Destination "C:\Program Files" -Recurse -Force
 
  Start-Process -FilePath "C:\Program Files\G40110\HpFirmwareUpdRec.exe" -ArgumentList "/s /b /r" -Wait

  Restart-Computer -Force
}
 
If ($Mode -eq "Uninstall") {
  # Avinstallerar...

}



```
