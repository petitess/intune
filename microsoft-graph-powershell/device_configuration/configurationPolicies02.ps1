Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All
#https://github.com/microsoftgraph/microsoft-graph-docs-contrib/blob/main/api-reference/beta/api/intune-deviceconfigv2-devicemanagementconfigurationpolicy-update.md
$baseUri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies" 

# Get all configuration policies
$Policies = (Invoke-MgGraphRequest -Method GET -Uri $baseUri).value
$Policies | Select-Object name, id

#Get a policy
$Policy = (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/15c1c269-342d-4422-b1d5-4e90b446c1ac?`$expand=settings")  | Select-Object -Property name, description, settings, platforms, technologies, templateReference
$Policy.templateReference.templateId = $null
$Policy.name = "Attack Surface Reduction Rules - Abc"
$JsonContent = $Policy | ConvertTo-Json -Depth 100 #| Out-File configurationPolicies02.json
# $JsonContent = Get-Content -Path configurationPolicies02.json

#Remove property "templateId" from JSON payload
#Create a new policy
Invoke-MgGraphRequest -Method POST -Uri $baseUri -Body $JsonContent 

$Patch = @"
{
  "name": "Attack Surface Reduction Rules - Abc",
  "description": "Blocks unwanted behaviors from:\nVBScript/JavaScript\nOffice\nUpdated by PATCH",
}
"@
#No support for updating settings for this endpoint
Invoke-MgGraphRequest -Method PATCH -Uri "$baseUri/1ec85495-8da7-45eb-ad96-af4ad51c777c" -Body $Patch 

#Get the new policy
$Policy = (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/1ec85495-8da7-45eb-ad96-af4ad51c777c?`$expand=settings") 
$Policy.description = "Blocks unwanted behaviors from:\nVBScript/JavaScript\nOffice\nUpdated by PUT"
#Get a setting
$Setting = $Policy.settings.settingInstance.groupSettingCollectionValue.children.choiceSettingValue `
| Where-Object { $_.value -eq "device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockofficecommunicationappfromcreatingchildprocesses_block" }

$Setting | ConvertTo-Json -Depth 100
#Update the setting
$Setting.value = "device_vendor_msft_policy_config_defender_attacksurfacereductionrules_blockofficecommunicationappfromcreatingchildprocesses_audit"
$Policy.templateReference.templateId = $null
$Policy.settings.settingInstance.groupSettingCollectionValue.children | ConvertTo-Json -Depth 100
$JsonContent = $Policy | ConvertTo-Json -Depth 100
Invoke-MgGraphRequest -Method PUT -Uri "$baseUri/1ec85495-8da7-45eb-ad96-af4ad51c777c" -Body $JsonContent 