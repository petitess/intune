#### Connect with company account
```pwsh
Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All, DeviceManagementApps.ReadWrite.All
```
### Authenticate to Microsoft Graph PowerShell using secret - Invoke-RestMethod
```pwsh
$appid = $env:mg_x_root_01_id
$tenantid = $env:x_tenant
$secret = $env:mg_x_root_01_secret
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
