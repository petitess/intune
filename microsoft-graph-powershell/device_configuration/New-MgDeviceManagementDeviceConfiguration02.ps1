Get-MgDeviceManagementDeviceConfiguration | Select-Object DisplayName, Id, AdditionalProperties #| ConvertTo-Json
$AppLocker = Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq "Windows 11 AppLocker" | Select-Object AdditionalProperties 
$AppLocker.AdditionalProperties.omaSettings

$params = @{
    "@odata.type" = "#microsoft.graph.windows10CustomConfiguration"
    description   = "Test"
    displayName   = "Windows 11 AppLocker - DEV"
    omaSettings   = @(
        @{
            "@odata.type" = "#microsoft.graph.omaSettingString"
            displayName   = "Applocker - Appx"
            omaUri        = "./Vendor/MSFT/AppLocker/ApplicationLaunchRestrictions/apps/StoreApps/Policy"
            value         = "$(Get-Content ".\xxx\applocker_appx.xml")"
        }
        @{
            "@odata.type" = "#microsoft.graph.omaSettingString"
            displayName   = "Applocker - DLL"
            omaUri        = "./Vendor/MSFT/AppLocker/ApplicationLaunchRestrictions/apps/DLL/Policy"
            value         = "$(Get-Content ".\xxx\applocker_dll.xml")"
        }
        @{
            "@odata.type" = "#microsoft.graph.omaSettingString"
            displayName   = "Applocker - EXE"
            omaUri        = "./Vendor/MSFT/AppLocker/ApplicationLaunchRestrictions/apps/EXE/Policy"
            value         = "$(Get-Content ".\xxx\applocker_exe.xml")"
        }
        @{
            "@odata.type" = "#microsoft.graph.omaSettingString"
            displayName   = "Applocker - MSI"
            omaUri        = "./Vendor/MSFT/AppLocker/ApplicationLaunchRestrictions/apps/MSI/Policy"
            value         = "$(Get-Content ".\xxx\applocker_msi.xml")"
        }
        @{
            "@odata.type" = "#microsoft.graph.omaSettingString"
            displayName   = "Applocker - Script"
            omaUri        = "./Vendor/MSFT/AppLocker/ApplicationLaunchRestrictions/apps/Script/Policy"
            value         = "$(Get-Content ".\xxx\applocker_script.xml")"
        }
    )
}

New-MgDeviceManagementDeviceConfiguration -BodyParameter $params

$Config = Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq "Windows 11 AppLocker - DEV"
Remove-MgDeviceManagementDeviceConfiguration -DeviceConfigurationId $Config.Id
