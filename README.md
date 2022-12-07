### Install PowerShell SDK for Microsoft Intune Graph API

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Microsoft.Graph.Intune
Update-Module Microsoft.Graph.Intune
Connect-MSGraph -AdminConsent
```
