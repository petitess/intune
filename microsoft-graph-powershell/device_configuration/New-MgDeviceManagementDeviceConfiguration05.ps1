Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All, DeviceManagementApps.ReadWrite.All

(Get-MgDeviceManagementDeviceConfiguration -Filter "isof(%27microsoft.graph.windowsUpdateForBusinessConfiguration%27)")
$UpdateConfig = (Get-MgDeviceManagementDeviceConfiguration -DeviceConfigurationId "d9e079cb-f846-47ed-a11c-5e1de7597a44")

$UpdateConfig.DisplayName = "Semi Annual Update Channel ABC"
$UpdateConfig.Id = ""
$UpdateConfig.Description = "Updated: $(Get-Date)"

New-MgDeviceManagementDeviceConfiguration -BodyParameter $UpdateConfig

$UpdateConfig | ConvertTo-Json

$UpdateConfig = @{
    "@odata.context"                          = 'https://graph.microsoft.com/v1.0/$metadata#deviceManagement/deviceConfigurations/$entity'
    "@odata.type"                             = '#microsoft.graph.windowsUpdateForBusinessConfiguration'
    "Description"                             = "Updated: $(Get-Date)"
    "DisplayName"                             = "Semi Annual Update Channel ABC"
    "deliveryOptimizationMode"                = "userDefined"
    "prereleaseFeatures"                      = "userDefined"
    "automaticUpdateMode"                     = "autoInstallAndRebootAtMaintenanceTime"
    "microsoftUpdateServiceAllowed"           = $true
    "driversExcluded"                         = $true
    "qualityUpdatesDeferralPeriodInDays"      = 0
    "featureUpdatesDeferralPeriodInDays"      = 0
    "qualityUpdatesPaused"                    = $false
    "featureUpdatesPaused"                    = $false
    "qualityUpdatesPauseExpiryDateTime"       = "2024-11-22T09:15:22.1286915Z"
    "featureUpdatesPauseExpiryDateTime"       = "2024-11-22T09:15:25.2498241Z"
    "businessReadyUpdatesOnly"                = "businessReadyOnly"
    "skipChecksBeforeRestart"                 = $false
    "featureUpdatesRollbackWindowInDays"      = 10
    "qualityUpdatesWillBeRolledBack"          = $false
    "featureUpdatesWillBeRolledBack"          = $false
    "qualityUpdatesRollbackStartDateTime"     = "0001-01-01T00:00:00Z"
    "featureUpdatesRollbackStartDateTime"     = "0001-01-01T00:00:00Z"
    "deadlineForFeatureUpdatesInDays"         = 2
    "deadlineForQualityUpdatesInDays"         = 2
    "deadlineGracePeriodInDays"               = 0
    "postponeRebootUntilAfterDeadline"        = $false
    "autoRestartNotificationDismissal"        = "user"
    "scheduleRestartWarningInHours"           = 4
    "scheduleImminentRestartWarningInMinutes" = 60
    "userPauseAccess"                         = "disabled"
    "userWindowsUpdateScanAccess"             = "enabled"
    "updateNotificationLevel"                 = "defaultNotifications"
    "allowWindows11Upgrade"                   = $false
    "installationSchedule"                    = @{
      "@odata.type"      = '#microsoft.graph.windowsUpdateActiveHoursInstall'
      "activeHoursStart" = "07:00:00.0000000"
      "activeHoursEnd"   = "18:00:00.0000000"
    }
}

New-MgDeviceManagementDeviceConfiguration -BodyParameter $UpdateConfig
