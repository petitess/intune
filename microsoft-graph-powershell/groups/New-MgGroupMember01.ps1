((Invoke-MgGraphRequest -Uri "/beta/deviceManagement/managedDevices").value | Where-Object deviceName -EQ "FLY-5CGABCDEFGH" | Select-Object deviceName, azureADDeviceId)

$G4Model = ((Invoke-MgGraphRequest -Uri "/beta/deviceManagement/managedDevices").value | Where-Object model -EQ "HP Dragonfly 13.5 inch G4 Notebook PC" | Select-Object deviceName, azureADDeviceId)
$G4Model | ForEach-Object {

    $ObjectId = (Get-MgDevice -Filter "DisplayName eq '$($_.deviceName)'").Id
    $ObjectId
    New-MgGroupMember -GroupId '02a14d03-eff5-49bd-aae9-0787e19a869d' -DirectoryObjectId $ObjectId
}
