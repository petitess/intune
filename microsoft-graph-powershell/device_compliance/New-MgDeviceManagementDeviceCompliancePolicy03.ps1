Get-MgDeviceManagementDeviceCompliancePolicy

Get-MgDeviceManagementDeviceCompliancePolicy | Where-Object DisplayName -eq "macOS BYOD_CompliancePolicy" | Select-Object AdditionalProperties | ConvertTo-Json -Depth 20

$params = @{
    "@odata.type"                               = "#microsoft.graph.macOSCompliancePolicy"
    description                                 = "Test"
    displayName                                 = "macOS - test"
    passwordRequired                            = $true
    passwordBlockSimple                         = $true
    passwordMinimumLength                       = 8
    passwordRequiredType                        = "deviceDefault"
    osMinimumVersion                            = "15.6"
    systemIntegrityProtectionEnabled            = $false
    deviceThreatProtectionEnabled               = $false
    deviceThreatProtectionRequiredSecurityLevel = "unavailable"
    storageRequireEncryption                    = $true
    firewallEnabled                             = $true
    firewallBlockAllIncoming                    = $false
    firewallEnableStealthMode                   = $false
}

$params = @{
    "@odata.type"                               = "#microsoft.graph.macOSCompliancePolicy"
    description                                 = "Test"
    displayName                                 = "macOS - InnovationLab - test"
    passwordRequired                            = $false
    passwordBlockSimple                         = $false
    passwordRequiredType                        = "deviceDefault"
    osMinimumVersion                            = "15.4"
    systemIntegrityProtectionEnabled            = $true
    deviceThreatProtectionEnabled               = $false
    deviceThreatProtectionRequiredSecurityLevel = "unavailable"
    storageRequireEncryption                    = $true
    firewallEnabled                             = $true
    firewallBlockAllIncoming                    = $false
    firewallEnableStealthMode                   = $false
}

$params = @{
    "@odata.type"                               = "#microsoft.graph.macOSCompliancePolicy"
    description                                 = "Test"
    displayName                                 = "macOS BYOD_CompliancePolicy - test"
    passwordRequired                            = $true
    passwordBlockSimple                         = $true
    passwordRequiredType                        = "deviceDefault"
    systemIntegrityProtectionEnabled            = $false
    deviceThreatProtectionEnabled               = $false
    deviceThreatProtectionRequiredSecurityLevel = "unavailable"
    storageRequireEncryption                    = $true
    firewallEnabled                             = $false
    firewallBlockAllIncoming                    = $false
    firewallEnableStealthMode                   = $false
}

New-MgDeviceManagementDeviceCompliancePolicy -BodyParameter $params
