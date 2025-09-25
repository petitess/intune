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
