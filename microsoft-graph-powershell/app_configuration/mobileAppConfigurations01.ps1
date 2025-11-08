Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All, DeviceManagementApps.ReadWrite.All

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppConfigurations").value
$AppConfig = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppConfigurations/176b7a20-6a3a-4fe5-99b0-3f3e633db9ef") 
$AppConfig.displayName = "Defender_ATP_Supervised_Policy_ABC"
$AppConfig.id = ""
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppConfigurations" -Body ($AppConfig | ConvertTo-Json) -ContentType "application/json"

$AppConfig = @{
  "settings"           = @(
    @{
      appConfigKeyType  = "stringType"
      appConfigKeyValue = "{{issupervised}}"
      appConfigKey      = "issupervised"
    },
    @{
      appConfigKeyType  = "stringType"
      appConfigKeyValue = "true"
      appConfigKey      = "DisableSignOut"
    },
    @{
      appConfigKeyType  = "stringType"
      appConfigKeyValue = "{{userprincipalname}}"
      appConfigKey      = "IntuneMAMUPN"
    },
    @{
      appConfigKeyType  = "stringType"
      appConfigKeyValue = "{{userid}}"
      appConfigKey      = "IntuneMAMOID"
    }
  )
  "@odata.type"        = "#microsoft.graph.iosMobileAppConfiguration"
  "displayName"        = "Defender_ATP_Supervised_Policy_ABC"
  "description"        = "Updated: $(Get-Date)"
  "@odata.context"     = "https://graph.microsoft.com/beta/$metadata#deviceAppManagement/mobileAppConfigurations/$entity"
  "encodedSettingXml"  = $null
  "targetedMobileApps" = @(
    "f4fca105-010f-4aec-8149-0361d81f0be8"
  )
}

Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppConfigurations" -Body ($AppConfig | ConvertTo-Json) -ContentType "application/json"

$AppConfigUpdate = @{
  "@odata.type"        = "#microsoft.graph.iosMobileAppConfiguration"
  "displayName"        = "Defender_ATP_Supervised_Policy_ABC"
  "description"        = "Updated: $(Get-Date)"
  "@odata.context"     = "https://graph.microsoft.com/beta/$metadata#deviceAppManagement/mobileAppConfigurations/$entity"
  "encodedSettingXml"  = $null
  "targetedMobileApps" = @(
    "f4fca105-010f-4aec-8149-0361d81f0be8"
  )
}

Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppConfigurations/5dca3078-ed5f-4818-b36c-a20db8220e37" -Body ($AppConfigUpdate | ConvertTo-Json) -ContentType "application/json"
