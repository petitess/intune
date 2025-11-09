Connect-Graph -Scopes DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementScripts.ReadWrite.All, DeviceManagementApps.ReadWrite.All

(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations?`$filter=isof(%27microsoft.graph.windowsUpdateForBusinessConfiguration%27)").value.displayName
$UpdateConfig = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations/d9e079cb-f846-47ed-a11c-5e1de7597a44") 
$UpdateConfig = @{
  "@odata.type"                                             = "#microsoft.graph.windowsUpdateForBusinessConfiguration"
  "id"                                                      = ""
  "displayName"                                             = "Semi Annual Update Channel ABC"
  "description"                                             = ""
  "roleScopeTagIds"                                         = $UpdateConfig.roleScopeTagIds                   
  "microsoftUpdateServiceAllowed"                           = $UpdateConfig.microsoftUpdateServiceAllowed     
  "driversExcluded"                                         = $UpdateConfig.driversExcluded                   
  "qualityUpdatesDeferralPeriodInDays"                      = $UpdateConfig.qualityUpdatesDeferralPeriodInDays
  "featureUpdatesDeferralPeriodInDays"                      = $UpdateConfig.featureUpdatesDeferralPeriodInDays
  "allowWindows11Upgrade"                                   = $UpdateConfig.allowWindows11Upgrade             
  "qualityUpdatesPaused"                                    = $UpdateConfig.qualityUpdatesPaused             
  "featureUpdatesPaused"                                    = $UpdateConfig.featureUpdatesPaused              
  "businessReadyUpdatesOnly"                                = $UpdateConfig.businessReadyUpdatesOnly          
  "skipChecksBeforeRestart"                                 = $UpdateConfig.skipChecksBeforeRestart           
  "automaticUpdateMode"                                     = $UpdateConfig.automaticUpdateMode               
  "installationSchedule"                                    = @{
    "@odata.type"      = "#microsoft.graph.windowsUpdateActiveHoursInstall"
    "activeHoursStart" = $UpdateConfig.installationSchedule.activeHoursStart
    "activeHoursEnd"   = $UpdateConfig.installationSchedule.activeHoursEnd
  }
  "userPauseAccess"                                         = $UpdateConfig.userPauseAccess                                        
  "userWindowsUpdateScanAccess"                             = $UpdateConfig.userWindowsUpdateScanAccess                            
  "updateNotificationLevel"                                 = $UpdateConfig.updateNotificationLevel                                
  "updateWeeks"                                             = $UpdateConfig.updateWeeks                                            
  "featureUpdatesRollbackWindowInDays"                      = $UpdateConfig.featureUpdatesRollbackWindowInDays                     
  "deadlineForFeatureUpdatesInDays"                         = $UpdateConfig.deadlineForFeatureUpdatesInDays                        
  "deadlineForQualityUpdatesInDays"                         = $UpdateConfig.deadlineForQualityUpdatesInDays                        
  "deadlineGracePeriodInDays"                               = $UpdateConfig.deadlineGracePeriodInDays                              
  "postponeRebootUntilAfterDeadline"                        = $UpdateConfig.postponeRebootUntilAfterDeadline                       
  "engagedRestartDeadlineInDays"                            = $UpdateConfig.engagedRestartDeadlineInDays                           
  "engagedRestartSnoozeScheduleInDays"                      = $UpdateConfig.engagedRestartSnoozeScheduleInDays                     
  "engagedRestartTransitionScheduleInDays"                  = $UpdateConfig.engagedRestartTransitionScheduleInDays                 
  "engagedRestartSnoozeScheduleForFeatureUpdatesInDays"     = $UpdateConfig.engagedRestartSnoozeScheduleForFeatureUpdatesInDays    
  "engagedRestartTransitionScheduleForFeatureUpdatesInDays" = $UpdateConfig.engagedRestartTransitionScheduleForFeatureUpdatesInDays
  "autoRestartNotificationDismissal"                        = $UpdateConfig.autoRestartNotificationDismissal                       
  "scheduleRestartWarningInHours"                           = $UpdateConfig.scheduleRestartWarningInHours                          
  "scheduleImminentRestartWarningInMinutes"                 = $UpdateConfig.scheduleImminentRestartWarningInMinutes                
}
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations" -Body ($UpdateConfig | ConvertTo-Json -Depth 100) -ContentType "application/json"

$UpdateConfig = @{
  "@odata.type"                                             = "#microsoft.graph.windowsUpdateForBusinessConfiguration"
  "id"                                                      = ""
  "displayName"                                             = "Semi Annual Update Channel ABC"
  "description"                                             = ""
  "roleScopeTagIds"                                         = @()
  "microsoftUpdateServiceAllowed"                           = $true
  "driversExcluded"                                         = $false
  "qualityUpdatesDeferralPeriodInDays"                      = 0
  "featureUpdatesDeferralPeriodInDays"                      = 0
  "allowWindows11Upgrade"                                   = $false
  "qualityUpdatesPaused"                                    = $false
  "featureUpdatesPaused"                                    = $false
  "businessReadyUpdatesOnly"                                = "userDefined"
  "skipChecksBeforeRestart"                                 = $false
  "automaticUpdateMode"                                     = "autoInstallAtMaintenanceTime"
  "installationSchedule"                                    = @{
    "@odata.type"      = "#microsoft.graph.windowsUpdateActiveHoursInstall"
    "activeHoursStart" = "08:00:00.0000000"
    "activeHoursEnd"   = "17:00:00.0000000"
  }
  "userPauseAccess"                                         = "enabled"
  "userWindowsUpdateScanAccess"                             = "enabled"
  "updateNotificationLevel"                                 = "defaultNotifications"
  "updateWeeks"                                             = $null
  "featureUpdatesRollbackWindowInDays"                      = 10
  "deadlineForFeatureUpdatesInDays"                         = $null
  "deadlineForQualityUpdatesInDays"                         = $null
  "deadlineGracePeriodInDays"                               = $null
  "postponeRebootUntilAfterDeadline"                        = $null
  "engagedRestartDeadlineInDays"                            = $null
  "engagedRestartSnoozeScheduleInDays"                      = $null
  "engagedRestartTransitionScheduleInDays"                  = $null
  "engagedRestartSnoozeScheduleForFeatureUpdatesInDays"     = $null
  "engagedRestartTransitionScheduleForFeatureUpdatesInDays" = $null
  "autoRestartNotificationDismissal"                        = "notConfigured"
  "scheduleRestartWarningInHours"                           = $null
  "scheduleImminentRestartWarningInMinutes"                 = $null
}

# Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations" -Body $UpdateConfig
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations" -Body ($UpdateConfig | ConvertTo-Json -Depth 100) -ContentType "application/json"
