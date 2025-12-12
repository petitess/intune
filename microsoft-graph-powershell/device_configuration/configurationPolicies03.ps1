$baseUri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies" 

# Get all configuration policies
$Policies = (Invoke-MgGraphRequest -Method GET -Uri $baseUri).value | Where-Object platforms -eq "macOS"
$Policies | Select-Object name, id

$Policy = (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/2bf91c48-4139-4c91-957c-69c303491186?`$expand=settings") | Select-Object -Property name, description, settings, platforms, technologies, templateReference
$Policy.templateReference.templateId = $null
$Policy.name = "macOS - ABR - System Extension Settings Catalog - test"
$JsonContent = $Policy | ConvertTo-Json -Depth 100 
Invoke-MgGraphRequest -Method POST -Uri $baseUri -Body $JsonContent 

$Configs = (Invoke-MgGraphRequest -Method GET -Uri $baseUri).value | Where-Object platforms -eq "macOS"
$Configs | ForEach-Object {
    (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/$($_.id)?`$expand=settings") `
    | Select-Object -Property name, description, settings, platforms, technologies, templateReference `
    | ConvertTo-Json -Depth 100 | Out-File "C:\temp\macos_settings_catalog\$($_.name)_settings_catalog.json"
}

$JsonContent = Get-Content "C:\temp\macos_settings_catalog\macOS - ABR - System Extension Settings Catalog_settings_catalog.json"
Invoke-MgGraphRequest -Method POST -Uri $baseUri -Body $JsonContent 
