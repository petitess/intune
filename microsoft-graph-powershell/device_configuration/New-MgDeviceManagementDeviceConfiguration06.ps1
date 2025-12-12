Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq "macOS - ALL Wallpaper mobileconf" | Select-Object AdditionalProperties | ConvertTo-Json -Depth 100 | Out-File "C:\temp\configs\x.json"

$Configs = (Get-MgDeviceManagementDeviceConfiguration -Filter "isof(%27microsoft.graph.macOSCustomConfiguration%27)").DisplayName

$Configs | ForEach-Object {
    Get-MgDeviceManagementDeviceConfiguration | Where-Object DisplayName -eq $_ `
    | ConvertTo-Json -Depth 100 | Out-File "C:\temp\macos_custom_config\$($_)_custom.json"
}

$params = @{
    "@odata.type"   = "#microsoft.graph.macOSCustomConfiguration"
    description     = "Test"
    displayName     = "macOS - ALL Wallpaper mobileconf - test"
    payloadName     = "Wallpaper"
    payloadFileName = "wallpaper.mobileconfig"
    payload         = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+CjxwbGlzdCB2ZXJzaW9uPSIxLjAiPgo8ZGljdD4KCTxrZXk+UGF5bG9hZENvbnRlbnQ8L2tleT4KCTxhcnJheT4KCQk8ZGljdD4KCQkJPGtleT5QYXlsb2FkRGlzcGxheU5hbWU8L2tleT4KCQkJPHN0cmluZz5EZXNrdG9wPC9zdHJpbmc+CgkJCTxrZXk+UGF5bG9hZEVuYWJsZWQ8L2tleT4KCQkJPHRydWUvPgoJCQk8a2V5PlBheWxvYWRJZGVudGlmaWVyPC9rZXk+CgkJCTxzdHJpbmc+Y29tLnNldHdhbGxwYXBlcjwvc3RyaW5nPgoJCQk8a2V5PlBheWxvYWRUeXBlPC9rZXk+CgkJCTxzdHJpbmc+Y29tLmFwcGxlLmRlc2t0b3A8L3N0cmluZz4KCQkJPGtleT5QYXlsb2FkVVVJRDwva2V5PgoJCQk8c3RyaW5nPjI0QjAwQzMwLTRFNEEtNENBOS1BNzVGLTkzMzFCODhBREU5Rjwvc3RyaW5nPgoJCQk8a2V5PlBheWxvYWRWZXJzaW9uPC9rZXk+CgkJCTxpbnRlZ2VyPjE8L2ludGVnZXI+CgkJCTxrZXk+b3ZlcnJpZGUtcGljdHVyZS1wYXRoPC9rZXk+CgkJCTxzdHJpbmc+L1VzZXJzL1NoYXJlZC93YWxscGFwZXIuanBnPC9zdHJpbmc+CgkJPC9kaWN0PgoJPC9hcnJheT4KCTxrZXk+UGF5bG9hZERlc2NyaXB0aW9uPC9rZXk+Cgk8c3RyaW5nPkxvY2tzIHRoZSB3YWxscGFwZXIgcGF0aDwvc3RyaW5nPgoJPGtleT5QYXlsb2FkRGlzcGxheU5hbWU8L2tleT4KCTxzdHJpbmc+RGVza3RvcCBXYWxscGFwZXIgUGljdHVyZTwvc3RyaW5nPgoJPGtleT5QYXlsb2FkSWRlbnRpZmllcjwva2V5PgoJPHN0cmluZz5jb20uc2V0d2FsbHBhcGVyPC9zdHJpbmc+Cgk8a2V5PlBheWxvYWRPcmdhbml6YXRpb248L2tleT4KCTxzdHJpbmc+SW50dW5lPC9zdHJpbmc+Cgk8a2V5PlBheWxvYWRSZW1vdmFsRGlzYWxsb3dlZDwva2V5PgoJPGZhbHNlLz4KCTxrZXk+UGF5bG9hZFNjb3BlPC9rZXk+Cgk8c3RyaW5nPlN5c3RlbTwvc3RyaW5nPgoJPGtleT5QYXlsb2FkVHlwZTwva2V5PgoJPHN0cmluZz5Db25maWd1cmF0aW9uPC9zdHJpbmc+Cgk8a2V5PlBheWxvYWRVVUlEPC9rZXk+Cgk8c3RyaW5nPjgzNTIzQjlCLTUxMUItNDU0RS05QTNFLURCRUNFREE4QzI5MTwvc3RyaW5nPgoJPGtleT5QYXlsb2FkVmVyc2lvbjwva2V5PgoJPGludGVnZXI+MTwvaW50ZWdlcj4KPC9kaWN0Pgo8L3BsaXN0Pgo="
}

New-MgDeviceManagementDeviceConfiguration -BodyParameter $params

$JsonFile = Get-Content "C:\temp\macos_custom_config\macOS - MDE AutoUpdate_custom.json" | ConvertFrom-Json
$params = @{
    "@odata.type"   = "#microsoft.graph.macOSCustomConfiguration"
    description     = "Test"
    displayName     = "macOS - MDE AutoUpdate - test"
    payloadName     = $JsonFile.AdditionalProperties.payloadName
    payloadFileName = $JsonFile.AdditionalProperties.payloadFileName
    payload         = $JsonFile.AdditionalProperties.payload
}

New-MgDeviceManagementDeviceConfiguration -BodyParameter $params
