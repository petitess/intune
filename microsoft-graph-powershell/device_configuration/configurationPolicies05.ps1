param (
    [Parameter(Mandatory)]
    [String]
    $Environment
)

$groupIdsTest = @(
    @{
        "target" = @{
            "@odata.type" = "#microsoft.graph.exclusionGroupAssignmentTarget"
            "groupId"     = "bab1234a-a5b2-4497-a64e-77661f6c7417"
        }
    }
    @{
        "target" = @{
            "@odata.type" = "#microsoft.graph.groupAssignmentTarget"
            "groupId"     = "12345a12-b851-4d3b-9f7b-fb768c1a9799"
        }
    }
)
$groupIdsProd = @(
    @{
        "target" = @{
            "@odata.type" = "#microsoft.graph.exclusionGroupAssignmentTarget"
            "groupId"     = "1234fe55-6f66-4237-a822-a392f4b223c7"
        }
    }
    @{
        "target" = @{
            "@odata.type" = "#microsoft.graph.groupAssignmentTarget"
            "groupId"     = "123425da-5504-4dc3-8964-140ddb2313cb"
        }
    }
)

$xmlFiles = Get-ChildItem -Path ".\Supplemental\*\*.xml"
$token = az account get-access-token --resource https://graph.microsoft.com/ --query accessToken -o tsv
$headers = @{Authorization = "Bearer $token"; "Content-type" = "application/json" }

$uriExisting = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies?`$filter=templateReference/templateFamily eq 'endpointSecurityApplicationControl'"
$all = @()
while ($uriExisting) {
    try {
        $resp = Invoke-RestMethod -Method Get -Uri $uriExisting -Headers $headers
    }
    catch {
        Write-Error "Retrieval failed. Error: $($_.Exception.Message)"
    }
    if ($resp.value) {
        $all += $resp.value
    }
    $uriExisting = $resp.'@odata.nextLink'
}

Write-Warning "Total policies found: $($all.Count)"

$xmlFiles | ForEach-Object {
    $xmlContent = Get-Content -Path $_.FullName
    Write-Host "Processing file: $($_.FullName)"
    if ($Environment -eq "prod") {
        # Write-Host "Using prod group IDs"
        $policyName = "Windows 11 Supplemental $($_.BaseName)"
    }
    elseif ($Environment -eq "test") {
        Write-Host "Using test group IDs"
        $policyName = "Windows 11 Supplemental $($_.BaseName) - Test"
    }
    $body = ConvertTo-Json -Depth 100 @{
        "name"              = $policyName
        "description"       = "Updated by pipeline on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        "settings"          = @(
            @{
                "settingInstance" = @{
                    "@odata.type"                      = "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance"
                    "choiceSettingValue"               = @{
                        "@odata.type"                   = "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue"
                        "children"                      = @(
                            @{
                                "@odata.type"         = "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance"
                                "simpleSettingValue"  = @{
                                    "@odata.type" = "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                                    "value"       = "$xmlContent"
                                }
                                "settingDefinitionId" = "device_vendor_msft_policy_config_applicationcontrolv2_xmlupload"
                            }
                        )
                        "settingValueTemplateReference" = @{
                            "settingValueTemplateId" = "8e9847a2-8a1b-4168-a5fc-4a99cd8cd480"
                        }
                        "value"                         = "device_vendor_msft_policy_config_applicationcontrolv2_buildoptions_upload_xml_selected"
                    }
                    "settingDefinitionId"              = "device_vendor_msft_policy_config_applicationcontrolv2_buildoptions"
                    "settingInstanceTemplateReference" = @{
                        "settingInstanceTemplateId" = "abc5b8cd-63a0-4a1c-a34d-da84d9a93f62"
                    }
                }
            }
        )
        "roleScopeTagIds"   = @(
            "0"
        )
        "platforms"         = "windows10"
        "technologies"      = "mdm"
        "templateReference" = @{
            "templateId" = "d3849ba8-bf95-467c-9640-aa2334eae9e3_1"
        }
    }

    $policy = $all | Where-Object { $_.name -eq "$policyName" } 

    if ($policy) {
        Write-Warning "Policy already exists: $($policy.name). Updating..."
        $uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies"
        try {
            (Invoke-RestMethod -Method PUT -Uri "$uri/$($policy.id)" -Headers $headers -Body $body)
        }
        catch {
            Write-Error "Update failed: $($policyName). Error: $($_.Exception.Message)"
        }
    }
    else {
        Write-Warning "Policy does not exist. Creating: $($policyName)"
        $uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies"
        try {
            $policy = (Invoke-RestMethod -Method POST -Uri $uri -Headers $headers -Body $body)
        }
        catch {
            Write-Error "Creation failed: $($policyName). Error: $($_.Exception.Message)"
        }
    }

    $uriAssign = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies/$($policy.id)/assign"
    $bodyAssigment = ConvertTo-Json -Depth 100 @{
        "assignments" = ($Environment -eq "prod") ? $groupIdsProd : $groupIdsTest
    }

    try {
        (Invoke-RestMethod -Method POST -Uri $uriAssign -Headers $headers -Body $bodyAssigment)
        Write-Warning "Group assignment successful: $($policyName)"
    }
    catch {
        Write-Error "Assignment failed: $($policyName). Error: $($_.Exception.Message)"
    }
}




