$CertConfigs = (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/?`$filter=isof(%27microsoft.graph.macOSTrustedRootCertificate%27)").value
$CertConfigs | Select-Object displayName, id, '@odata.type'

$MacOSRootCert = @{
    id                     = "00000000-0000-0000-0000-000000000000"
    displayName            = "cert - test"
    roleScopeTagIds        = @("0")
    "@odata.type"          = "#microsoft.graph.macOSTrustedRootCertificate"
    deploymentChannel      = "deviceChannel"
    certFileName           = "IT Glue SSO.cer"
    trustedRootCertificate = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tDQpNSUlDOERDQ0FkaWdBd0lCQWdJUWZIQVEzcllSWll0TlZWR0RFWnBZUnpBTkJna3Foa2lHOXcwQkFRc0ZBREEwTVRJd01BWURWUVFEDQpFeWxOYVdOeWIzTnZablFnUVhwMWNtVWdSbVZrWlhKaGRHVmtJRk5UVHlCRFpYSjBhV1pwWTJGMFpUQWVGdzB5TlRBNE1EVXdPVEV6DQpNVGRhRncweU9EQTRNRFV3T1RFek1EWmFNRFF4TWpBd0JnTlZCQU1US1UxcFkzSnZjMjltZENCQmVuVnlaU0JHWldSbGNtRjBaV1FnDQpVMU5QSUVObGNuUnBabWxqWVhSbE1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBMGlLNThadUFKM3YxDQpwTEZZMnJXa3pMUkdiSUJ2SmppMkN1cjgxcHVtVkNYZHVFaEtrSXpRZkJtMkQ2dWxSdGhkWTllZDJSdklrS1hESGwzUmVXSXdqMVhXDQpXMjJFd0MyTm5ERGE0Rmp5bVlYN1lGaWZXV2kwZGxUUjBNajhNcWdYTlRPcXlzbmdZWWdWaXprWDJqV2R6NWRSb0UrOTl4c25kSzg0DQpyZ3JLOUw0RnlGYnA0WnEwenFNdm9menRHZW1VVkZ3K25KdXY3NWI2US92TjFQekFoYzBpdHE1Rlp4T21vWS9qT3U1UTRVTUFJekQxDQpudWZhOVc2SjFNZDlPZldyVTNDaGJZaHEyZWpkdXNkUlcyWGJWc1A3MnpFT3BGSHFwWExWM0pUUmZwY1VGRTRtaHMxVmV0RHd0dDFBDQpBUituL01peGZhMUpWN2JrTVg5a29zU0hlUUlEQVFBQk1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQUVzYW03WmxaNk1EWWJ3MmRBDQptQXlVRHRjc09xbUJUT2cwSEtYa3F2ckgzclQySzdJRVg3amFFdi9Bb2VLMTNCK0FabGdUNFZRQnNTMlRTdzFDaUZLUGFCT3QxWGhRDQp0WmFuQkh6aHRlWkhGdUhnRXV3SXFJa1BENEI0TlVGWnVHWXd2N0hCTW9iUXpxTmsySDhWbWR1STErRE5WTkdSVWFCMERQcitvTjFVDQp6NzluaWRtWUhlaURLVmlYK1ZUbXdOdEtVckQ5YmNQc2FzcnlhSkUxSG85c2E0K01GOStkLzRVWW5BL0xPcFdZRytieDl4V1dSMGg1DQpQSHM2ZnI3Y05uZ1BHbUQ3Tk5ERE9XRkpERlpSNm5pTWdJbmhWU1dnZENOVjFTTVB1SFNObnVRb2o4bVN2U2lBU0RTanBncm9UZXp6DQpPT2M4b2o0clNadFJjVkFOOXhBVw0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQ0K"
}

$jsonBody = $MacOSRootCert | ConvertTo-Json -Depth 10
Invoke-MgGraphRequest -Method POST -Uri $baseUri -Body $jsonBody 
Invoke-MgGraphRequest -Method GET -Uri "$baseUri/28f262a7-bc5c-4909-a55f-a95c54dbc9c8"
Invoke-MgGraphRequest -Method DELETE -Uri "$baseUri/28f262a7-bc5c-4909-a55f-a95c54dbc9c8"

$ScepConfigs = (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/?`$filter=isof(%27microsoft.graph.macOSScepCertificateProfile%27)").value
$ScepConfigs | Select-Object displayName, id, '@odata.type'

$ScepConfigs | ForEach-Object {
    (Invoke-MgGraphRequest -Method GET -Uri "$baseUri/$($_.id)") | ConvertTo-Json -Depth 100 `
    | Out-File "C:\temp\macos_scep_config\$($_.displayName)_scep_config.json"
}

$JsonContent = Get-Content "C:\temp\macos_scep_config\macOS - CloudPKI Device Cert_scep_config.json" | ConvertFrom-Json

$MacOSScepProfile = @{
    id                             = "00000000-0000-0000-0000-000000000000"   # Will be ignored on POST, required on PATCH/PUT
    displayName                    = $JsonContent.displayName  
    roleScopeTagIds                = $JsonContent.roleScopeTagIds
    "@odata.type"                  = "#microsoft.graph.macOSScepCertificateProfile"
    renewalThresholdPercentage     = $JsonContent.renewalThresholdPercentage
    deploymentChannel              = $JsonContent.deploymentChannel  
    certificateStore               = $JsonContent.certificateStore 
    certificateValidityPeriodScale = $JsonContent.certificateValidityPeriodScale  
    certificateValidityPeriodValue = $JsonContent.certificateValidityPeriodValue
    subjectNameFormat              = $JsonContent.subjectNameFormat
    subjectNameFormatString        = $JsonContent.subjectNameFormatString
    scepServerUrls                 = $JsonContent.scepServerUrls
    keyUsage                       = $JsonContent.keyUsage
    keySize                        = $JsonContent.keySize  
    extendedKeyUsages              = $JsonContent.extendedKeyUsages
    ##Root cert must be created first
    "rootCertificate@odata.bind"   = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations('28f262a7-bc5c-4909-a55f-a95c54dbc9c8')"
}

$jsonBody = $MacOSScepProfile | ConvertTo-Json -Depth 10
Invoke-MgGraphRequest -Method POST -Uri $baseUri -Body $jsonBody 
