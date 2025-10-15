$Script = Invoke-MgGraphRequest -Uri "/beta/deviceManagement/deviceManagementScripts/0765de89-c0ff-4354-83ec-114fd1c87848"
[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($Script.scriptContent))) | Out-File $Script.fileName


$PsScript = @'
$FavouritesLocation = [Environment]::GetFolderPath("Favorites")
$FolderName = "Favoriter"
$ShortcutUrl1 = "https://www.google.com/"
$ShortcutName1 = "Google.url"

# Create the folder under Favourites
New-Item -ItemType "Directory" -Name $FolderName -Path $FavouritesLocation

#New-Object : Creates an instance of a Microsoft .NET Framework or COM object.
#-ComObject WScript.Shell: This creates an instance of the COM object that represents the WScript.Shell for invoke CreateShortCut
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut1 = $WScriptShell.CreateShortcut($FavouritesLocation + "\" + $FolderName + "\" + $ShortcutName1)
$Shortcut1.TargetPath = $ShortcutUrl1
#Save the Shortcut to the TargetPath
$Shortcut1.Save()
'@

$binaryData = [System.IO.File]::ReadAllBytes(".\CreateScript.ps1")
$base64EncodedData = [Convert]::ToBase64String($binaryData)

$binaryData = [System.Text.Encoding]::UTF8.GetBytes($PsScript)
$base64EncodedData = [System.Convert]::ToBase64String($binaryData)

$OrginalContent = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($base64EncodedData)))

$Body = ConvertTo-Json @{
    "@odata.context"      = "https://graph.microsoft.com/beta/$metadata#deviceManagement/deviceManagementScripts/$entity"
    description           = "$OrginalContent" #MAX 1500 .Substring(0, 1500)
    displayName           = "Win 10 - Test"
    fileName              = "CreateScript.ps1"
    enforceSignatureCheck = $false
    runAs32Bit            = $false
    scriptContent         = $base64EncodedData
    runAsAccount          = "user"
}

$Script = Invoke-MgGraphRequest -Uri "/beta/deviceManagement/deviceManagementScripts" -Method POST -Body $Body 

$Body = ConvertTo-Json @{
    "@odata.context"      = "https://graph.microsoft.com/beta/$metadata#deviceManagement/deviceManagementScripts/$entity"
    description           = "New Data" #MAX 1500 .Substring(0, 1500)
}

$Script = Invoke-MgGraphRequest -Uri "/beta/deviceManagement/deviceManagementScripts/40b91322-a3fc-440f-a0a1-ef2afbc0ff32" -Method PATCH -Body $Body 
