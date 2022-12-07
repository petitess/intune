### Install PowerShell SDK for Microsoft Intune Graph API

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Microsoft.Graph.Intune
Update-Module Microsoft.Graph.Intune
Connect-MSGraph -AdminConsent
Get-Command -module Microsoft.Graph.Intune
```
```
(Get-IntuneManagedDevice).Value | select deviceName, userPrincipalName, model, osversion
((Get-IntuneManagedDevice).Value).count
````
