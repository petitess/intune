Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All
#https://github.com/microsoftgraph/microsoft-graph-docs-contrib/blob/main/api-reference/beta/api/intune-deviceconfigv2-devicemanagementconfigurationpolicy-update.md
$baseUri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies" 

# Get all configuration policies
$Policies = (Invoke-MgGraphRequest -Method GET -Uri $baseUri).value
$Policies | Select-Object name, id

#Get a policy
$Policy = (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/2e9b9943-cc30-47ac-9b4d-5f217670aaa0?`$expand=settings")  | Select-Object -Property name, description, settings, platforms, technologies, templateReference
$Policy.templateReference.templateId = $null
$JsonContent = $Policy | ConvertTo-Json -Depth 100 #| Out-File configurationPolicies01.json
# $JsonContent = Get-Content -Path configurationPolicies01.json

#Remove property "templateId" from JSON payload
#Create a new policy
Invoke-MgGraphRequest -Method POST -Uri $baseUri -Body $JsonContent 

$Patch = @"
{
  "name": "Abc Security Baseline",
  "description": "Security Baseline for 24H2 Updated",
}
"@
#No support for updating settings for this endpoint
Invoke-MgGraphRequest -Method PATCH -Uri "$baseUri/7522e1ee-0bbf-4f2a-a9c3-17b68dc5cb10" -Body $Patch 

#Get the new policy
$Policy = (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/7522e1ee-0bbf-4f2a-a9c3-17b68dc5cb10?`$expand=settings") 
$Policy.description = "Security Baseline for 24H2 Updated using PUT"
#Get a setting
$Setting = $Policy.settings | Where-Object { $_.id -eq "210" }
$Setting | ConvertTo-Json -Depth 100
$Policy.templateReference.templateId = $null
#Update the setting
$Setting.settingInstance.choiceSettingValue.value = "device_vendor_msft_policy_config_dataprotection_allowdirectmemoryaccess_1"
$Policy.settings[210] | ConvertTo-Json -Depth 100
$JsonContent = $Policy | ConvertTo-Json -Depth 100
Invoke-MgGraphRequest -Method PUT -Uri "$baseUri/7522e1ee-0bbf-4f2a-a9c3-17b68dc5cb10" -Body $JsonContent
