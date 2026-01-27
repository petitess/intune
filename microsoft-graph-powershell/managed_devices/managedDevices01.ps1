#DeviceManagementManagedDevices.PrivilegedOperations.All  DeviceManagementManagedDevices.ReadWrite.All
(Invoke-MgGraphRequest -Method GET -Uri "/v1.0/deviceManagement/managedDevices?`$filter=userPrincipalName eq 'ven.ops.hp@abc.se'").value.deviceName
(Invoke-MgGraphRequest -Method GET -Uri "/v1.0/deviceManagement/managedDevices").value
(Invoke-MgGraphRequest -Method GET -Uri "/v1.0/deviceManagement/managedDevices?`$filter=operatingSystem eq 'iOS' and managedDeviceOwnerType eq 'company' and managementState eq 'wipepending'&`select=managementState, deviceName, userPrincipalName").value
(Invoke-MgGraphRequest -Method GET -Uri "/v1.0/deviceManagement/managedDevices?`$filter=operatingSystem eq 'iOS' and managedDeviceOwnerType eq 'personal' and managementState ne 'managed'").value.managedDeviceOwnerType
(Invoke-MgGraphRequest -Method GET -Uri "/v1.0/deviceManagement/managedDevices?`$filter=operatingSystem eq 'iOS' and managedDeviceOwnerType eq 'company' and managementState ne 'managed'").value.Count

$Device = (Invoke-MgGraphRequest -Method GET -Uri "/v1.0/deviceManagement/managedDevices?`$filter=deviceName eq 'iPhone-W73DHJR6RJ'").value

$DeviceId = $Device.id
$NewName = "iPhone-$($Device.userDisplayName)"
#The name is restored after some time to the previous name.
$DeviceUpdated = Invoke-MgGraphRequest -Method POST -Uri "/beta/deviceManagement/managedDevices/$DeviceId/setDeviceName" -Body @{
    "deviceName" = $NewName
}
