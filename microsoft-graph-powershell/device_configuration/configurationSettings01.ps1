Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/configurationSettings").value

$DeviceSettings = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/configurationSettings?`$filter=startswith(id, 'device_')").value
$DeviceSettings | ConvertTo-Json | Out-File device_settings.json

$ThisSetting = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/configurationSettings?`$filter=id eq 'device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess'").value
$ThisSetting 

$ThisSetting = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/configurationSettings/device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess")
$ThisSetting | ConvertTo-Json -Depth 100

$Json = @"
{
  "helpText": "",
  "version": "638960815959126030",
  "visibility": "settingsCatalog,template",
  "options": [
    {
      "helpText": null,
      "description": "Not allowed.",
      "displayName": "Block",
      "optionValue": {
        "settingValueTemplateReference": null,
        "value": 0,
        "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue"
      },
      "name": "Not allowed.",
      "itemId": "device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess_0",
      "dependedOnBy": [],
      "dependentOn": []
    },
    {
      "helpText": null,
      "description": "Allowed.",
      "displayName": "Allow",
      "optionValue": {
        "settingValueTemplateReference": null,
        "value": 1,
        "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue"
      },
      "name": "Allowed.",
      "itemId": "device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess_1",
      "dependedOnBy": [],
      "dependentOn": []
    }
  ],
  "infoUrls": [
    "https://docs.microsoft.com/en-us/windows/client-management/mdm/policy-csp-dataprotection#allowdirectmemoryaccess"
  ],
  "offsetUri": "/Config/DataProtection/AllowDirectMemoryAccess",
  "displayName": "Allow Direct Memory Access",
  "keywords": [
    "Allow Direct Memory Access",
    "Data Protection"
  ],
  "uxBehavior": "toggle",
  "id": "device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess",
  "applicability": {
    "windowsSkus": [
      "windowsEnterprise",
      "windowsProfessional",
      "windowsEducation",
      "windowsMultiSession",
      "iotEnterprise",
      "windowsCloudN",
      "windows11SE",
      "iotEnterpriseSEval"
    ],
    "technologies": "mdm,configManager,microsoftSense",
    "minimumSupportedVersion": "10.0.10240",
    "@odata.type": "#microsoft.graph.deviceManagementConfigurationWindowsSettingApplicability",
    "maximumSupportedVersion": null,
    "description": null,
    "platform": "windows10",
    "deviceMode": "none",
    "requiresAzureAd": false,
    "requiredAzureAdTrustType": "none",
    "configurationServiceProviderVersion": "1.0"
  },
  "riskLevel": "low",
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#deviceManagement/configurationSettings/$entity",
  "settingUsage": "configuration",
  "description": "This policy setting allows you to block direct memory access (DMA) for all hot pluggable PCI downstream ports until a user logs into Windows. Once a user logs in, Windows will enumerate the PCI devices connected to the host plug PCI ports. Every time the user locks the machine, DMA will be blocked on hot plug PCI ports with no children devices until the user logs in again. Devices which were already enumerated when the machine was unlocked will continue to function until unplugged. This policy setting is only enforced when BitLocker Device Encryption is enabled. Most restricted value is 0.",
  "referredSettingInformationList": [],
  "baseUri": "./Device/Vendor/MSFT/Policy",
  "occurrence": {
    "minDeviceOccurrence": 0,
    "maxDeviceOccurrence": 1
  },
  "categoryId": "22f2b16b-e1af-45fa-8d2f-687854b72c02",
  "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingDefinition",
  "rootDefinitionId": "device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess",
  "accessTypes": "add,delete,get,replace",
  "name": "AllowDirectMemoryAccess",
  "defaultOptionId": "device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess_1"
}
"@
