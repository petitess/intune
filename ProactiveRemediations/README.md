#### Remove Old VPN profile
##### Detection script
```pwsh
$VPN = Get-VpnConnection -Name "Visma VPN" -ErrorAction Ignore
if ($null -ne $VPN) {
    exit 1
}else {
    exit 0
}
```
##### Remediation script file
```pwsh
Remove-VpnConnection -Name "Visma VPN" -Force
```
##### Settings
```s
Run this script using the logged-on credentials: No
Enforce script signature check: No
Run script in 64-bit PowerShell: No
```

#### Remove rasphone.pbk
##### Detection script
```pwsh
﻿$Path = "$env:HOMEPATH\AppData\Local\Packages\Microsoft.AzureVpn_8wekyb3d8bbwe\LocalState\rasphone.pbk"
if (Test-Path -Path $Path) {
    exit 1
}
else {
    exit 0
}
```
##### Remediation script file
```pwsh
﻿$Path = "$env:HOMEPATH\AppData\Local\Packages\Microsoft.AzureVpn_8wekyb3d8bbwe\LocalState\rasphone.pbk"
Remove-Item $Path
```
##### Settings
```s
Run this script using the logged-on credentials: Yes
Enforce script signature check: No
Run script in 64-bit PowerShell: No
```

#### Create Local Admin
##### Detection script
```pwsh
$userName = “B3Admin”
$userExists = (Get-LocalUser).Name -Contains $userName 
if ($userExists) {  
  Write-Host “$userName exists”  
  Exit 0 
}  
Else { 
  Write-Host “$userName does not exist.” 
  Exit 1 
} 
```
##### Remediation script file
```pwsh
$localUser = “B3Admin”
$userExists = (Get-LocalUser).Name -Contains  $localUser
$LocalAdminGroup = (Get-LocalGroup).Name -like "Administrat*"
$EnrollmentID = Get-ScheduledTask | Where-Object { $_.TaskPath -like "*Microsoft*Windows*EnterpriseMgmt\*" } | Select-Object -ExpandProperty TaskPath -Unique | Where-Object { $_ -like "*-*-*" } | Split-Path -Leaf
if($userExists -eq $false) { 
  try{  
     New-LocalUser -Name  $localUser -Description “B3 Admin LAPS” -NoPassword -AccountNeverExpires -UserMayNotChangePassword
     Add-LocalGroupMember -Group “$LocalAdminGroup” -Member $localUser 
     Start-Process -FilePath "C:\Windows\system32\deviceenroller.exe" -Wait -ArgumentList "/o $EnrollmentID /c /b"
     Exit 0 
   }    
  Catch { 
     Write-error $_ 
     Exit 1 
   } 
} 
```
##### Settings
```s
Run this script using the logged-on credentials: No
Enforce script signature check: No
Run script in 64-bit PowerShell: Yes
```
#### Create shortcut
##### Detection script
```pwsh
﻿if (test-path 'C:\Users\Public\Desktop\Visma RDP.lnk') 
{
    exit 0
}
else
{
    exit 1
}
```
##### Remediation script file
```pwsh
﻿$IPofTargetMachine = '10.0.99.7'
$wshshell = New-Object -ComObject WScript.Shell
$lnk = $wshshell.CreateShortcut("C:\Users\Public\Desktop\Visma RDP.lnk")
$lnk.TargetPath = "%windir%\system32\mstsc.exe"
$lnk.Arguments = "/v:$IPofTargetMachine"
$lnk.Description = "Visma RDP"
$lnk.Save()
```
##### Settings
```s
Run this script using the logged-on credentials: No
Enforce script signature check: No
Run script in 64-bit PowerShell: No
```
