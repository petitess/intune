#### Connect with company account
```pwsh
Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All, DeviceManagementApps.ReadWrite.All
```
### Authenticate to Microsoft Graph PowerShell using secret - Invoke-RestMethod
```pwsh
$appid = "abc"
$tenantid = 'def'
$secret = 'ghi'
$body =  @{
    Grant_Type    = "client_credentials"
    Scope         =  "https://graph.microsoft.com/.default"
    Client_Id     = $appid
    Client_Secret = $secret
}
$connection = Invoke-RestMethod `
    -Uri "https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token" `
    -Method POST `
    -Body $body
$token = $connection.access_token
$secureToken = ConvertTo-SecureString $token -AsPlainText -Force
Connect-MgGraph -AccessToken $secureToken
Get-MgContext
```
