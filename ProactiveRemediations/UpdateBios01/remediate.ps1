$battery = Get-WmiObject -class win32_battery -property BatteryStatus | select-object BatteryStatus
$biosversion=Get-HPBIOSVersion
$allowedversions="1.09.00","1.10.01"
if ((-not ($allowedversions -contains $biosversion)) -and (((Get-WmiObject win32_battery).estimatedChargeRemaining -gt 70)-or($battery.BatteryStatus -eq 2))){
Get-HPBIOSUpdates -Version 1.09.00 -Flash -Bitlocker Suspend -Yes
}
exit 0