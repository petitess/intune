Get-MgDeviceManagementDeviceCompliancePolicy | Where-Object DisplayName -eq "Android Compliance Policy" | Select-Object AdditionalProperties | ConvertTo-Json

$params = @{
    "@odata.type"                                      = "#microsoft.graph.androidWorkProfileCompliancePolicy"
    description                                        = "Test"
    displayName                                        = "Android Compliance Policy - Test"
    passwordRequired                                   = $true
    passwordMinimumLength                              = 6
    passwordRequiredType                               = "numericComplex"
    passwordMinutesOfInactivityBeforeLock              = 5
    securityPreventInstallAppsFromUnknownSources       = $true
    securityDisableUsbDebugging                        = $true
    securityRequireVerifyApps                          = $false
    deviceThreatProtectionEnabled                      = $false
    deviceThreatProtectionRequiredSecurityLevel        = "unavailable"
    securityBlockJailbrokenDevices                     = $true
    osMinimumVersion                                   = "14"
    minAndroidSecurityPatchLevel                       = "2025-09-05"
    storageRequireEncryption                           = $true
    securityRequireSafetyNetAttestationBasicIntegrity  = $true
    securityRequireSafetyNetAttestationCertifiedDevice = $true
    securityRequireGooglePlayServices                  = $true
    securityRequireUpToDateSecurityProviders           = $true
    securityRequireCompanyPortalAppIntegrity           = $true
    scheduledActionsForRule               = @(
        @{    
            ruleName                      = "PasswordRequired"
            scheduledActionConfigurations = @(
                @{ 
                    actionType             = "block"
                    gracePeriodHours       = 0
                    notificationTemplateId = ""
                })
        }
    )
}

New-MgDeviceManagementDeviceCompliancePolicy -BodyParameter $params

$ComPolicy = Get-MgDeviceManagementDeviceCompliancePolicy | Where-Object DisplayName -eq "Android Compliance Policy - Test" 
Remove-MgDeviceManagementDeviceCompliancePolicy -DeviceCompliancePolicyId $ComPolicy.Id
