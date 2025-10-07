### Install BIOS through Win32 App installer

Download exe file for your BIOS version

Extract sp123456.exe 

Take the content and prepare the app by using the IntuneWinAppUtil.exe

Upload intunewin file in intune

##### Program
```s
Install command
HpFirmwareUpdRec.exe  -f "V90_01100000.bin" -s -b
Uninstall command
HpFirmwareUpdRec.exe  -f "V90_01100000.bin" -s -b
Device restart behavior
Intune will force a mandatory device restart
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
