Get-MgDeviceManagementDeviceConfiguration | Select-Object DisplayName, Id, AdditionalProperties #| ConvertTo-Json
$Configs = Get-MgDeviceManagementDeviceConfiguration | Select-Object AdditionalProperties 
$Configs.AdditionalProperties."@odata.type"
$AppLocker = Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq "Windows 10 Shared Device config" | Select-Object AdditionalProperties | ConvertTo-Json
$AppLocker.AdditionalProperties

$params = @{
    "@odata.type"         = "#microsoft.graph.sharedPCConfiguration"
    description           = "Test"
    displayName           = "Windows 10 Shared Device config - TEST"
    allowedAccounts       = "notConfigured"
    allowLocalStorage     = $true
    disableAccountManager = $true
    disableEduPolicies    = $true
    disablePowerPolicies  = $false
    disableSignInOnResume = $false
    enabled               = $true
    maintenanceStartTime  = "00:00:00.0000000"
}

New-MgDeviceManagementDeviceConfiguration -BodyParameter $params

$Config = Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq "Windows 10 Shared Device config - TEST"
Remove-MgDeviceManagementDeviceConfiguration -DeviceConfigurationId $Config.Id
