Get-MgDeviceManagementDeviceConfiguration | Select-Object DisplayName, Id, AdditionalProperties #| ConvertTo-Json
$Configs = Get-MgDeviceManagementDeviceConfiguration | Select-Object AdditionalProperties 
$Configs.AdditionalProperties."@odata.type"
$AppLocker = Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq "Windows 10 Shared Device Windows Settings" | Select-Object AdditionalProperties 
$AppLocker.AdditionalProperties.omaSettings

$params = @{
    "@odata.type" = "#microsoft.graph.windows10CustomConfiguration"
    description   = "Test"
    displayName   = "Windows 10 Shared Device Windows Settings - TEST"
    omaSettings   = @(
        @{
            "@odata.type" = "#microsoft.graph.omaSettingInteger"
            displayName   = "DisableOneDriveFileSync"
            omaUri        = "./Device/Vendor/MSFT/Policy/Config/System/DisableOneDriveFileSync"
            value         = "0"
        }
        @{
            "@odata.type" = "#microsoft.graph.omaSettingInteger"
            displayName   = "MDMWinsOverGP"
            omaUri        = "./Device/Vendor/MSFT/Policy/Config/ControlPolicyConflict/MDMWinsOverGP"
            value         = "1"
        }
        @{
            "@odata.type" = "#microsoft.graph.omaSettingInteger"
            displayName   = "UserAccountControl_BehaviorOfTheElevationPromptForStandardUsers"
            omaUri        = "./Vendor/MSFT/Policy/Config/LocalPoliciesSecurityOptions/UserAccountControl_BehaviorOfTheElevationPromptForStandardUsers"
            value         = "1"
        }
    )
}

New-MgDeviceManagementDeviceConfiguration -BodyParameter $params

$Config = Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq "Windows 10 Shared Device Windows Settings - TEST"
Remove-MgDeviceManagementDeviceConfiguration -DeviceConfigurationId $Config.Id
