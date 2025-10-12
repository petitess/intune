Get-MgDeviceManagementDeviceCompliancePolicy | Where-Object DisplayName -eq "Windows 10/11 Compliance Policy" | Select-Object AdditionalProperties | ConvertTo-Json

$params = @{
    "@odata.type"                         = "#microsoft.graph.windows10CompliancePolicy"
    description                           = "Test"
    displayName                           = "Windows 10/11 Compliance Policy - Test"
    passwordRequired                      = $false
    passwordBlockSimple                   = $false
    passwordRequiredToUnlockFromIdle      = $false
    passwordMinutesOfInactivityBeforeLock = 10
    passwordMinimumLength                 = 5
    passwordRequiredType                  = "deviceDefault"
    requireHealthyDeviceReport            = $false
    osMinimumVersion                      = "10.0.22631.4830"
    earlyLaunchAntiMalwareDriverEnabled   = $false
    bitLockerEnabled                      = $false
    secureBootEnabled                     = $true
    codeIntegrityEnabled                  = $false
    storageRequireEncryption              = $false
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

$ComPolicy = Get-MgDeviceManagementDeviceCompliancePolicy | Where-Object DisplayName -eq "Windows 10/11 Compliance Policy - Test" 
Remove-MgDeviceManagementDeviceCompliancePolicy -DeviceCompliancePolicyId $ComPolicy.Id
