$Script = Invoke-MgGraphRequest -Uri "/beta/deviceManagement/deviceHealthScripts/57c12055-a40b-4b4c-bab6-6c57a3acfd73"

(Invoke-MgGraphRequest -Uri "/beta/deviceManagement/deviceHealthScripts").value | Select-Object deviceHealthScriptType, remediationScriptParameters

[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($Script.detectionScriptContent))) | Out-File detectionScriptContent.ps1
[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($Script.remediationScriptContent))) | Out-File remediationScriptContent.ps1

$PsScriptDetection = @'
$path = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
$name = "bEnableGentech"
$type = "DWORD"
$value = 0

Try {
    $Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    If ($Registry -eq $Value){
        Write-Output "Compliant"
        Exit 0
    } 
    else {
    Write-Warning "Not Compliant"
    Exit 1
    }
} 
Catch {
    Write-Warning "Not Compliant"
    Exit 1
}
'@

$binaryDataDetection = [System.Text.Encoding]::UTF8.GetBytes($PsScriptDetection)
$base64EncodedDataDetection = [System.Convert]::ToBase64String($binaryDataDetection)

$OrginalContentDetection = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($base64EncodedDataDetection)))


$PsScriptRemediation = @'
#Fileext
$regkey="HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
$name="bEnableGentech"
$value=0

#Registry Template
If (!(Test-Path $regkey))
{
    New-Item -Path $regkey -ErrorAction stop
}

if (!(Get-ItemProperty -Path $regkey -Name $name -ErrorAction SilentlyContinue))
{
    New-ItemProperty -Path $regkey -Name $name -Value $value -PropertyType DWORD -ErrorAction stop
    write-output "Created regkey, remediation complete"
    exit 0
}

set-ItemProperty -Path $regkey -Name $name -Value $value -ErrorAction stop
write-output "Updated regkey, remediation complete"
exit 0
'@

$binaryDataRemediation = [System.Text.Encoding]::UTF8.GetBytes($PsScriptRemediation)
$base64EncodedDataRemediation = [System.Convert]::ToBase64String($binaryDataRemediation)

$OrginalContentRemediation = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($base64EncodedDataRemediation)))

# $binaryData = [System.IO.File]::ReadAllBytes(".\CreateScript.ps1")
# $base64EncodedData = [Convert]::ToBase64String($binaryData)

$Body = ConvertTo-Json @{
    "@odata.context"            = "https://graph.microsoft.com/beta/$metadata#deviceManagement/deviceHealthScripts/$entity"
    displayName                 = "Adobe Acrobat Disable AI (registry) - Test"
    detectionScriptContent      = "$base64EncodedDataDetection"
    publisher                   = ""
    deviceHealthScriptType      = "deviceHealthScript"
    roleScopeTagIds             = @()
    remediationScriptParameters = @()
    enforceSignatureCheck       = $false
    description                 = ""
    remediationScriptContent    = $base64EncodedDataRemediation
    runAs32Bit                  = $true
    runAsAccount                = "system"
    isGlobalScript              = $false
    highestAvailableVersion     = ""
    detectionScriptParameters   = @()
}

$Script = Invoke-MgGraphRequest -Uri "/beta/deviceManagement/deviceHealthScripts" -Method POST -Body $Body 

$Body = ConvertTo-Json @{
    "@odata.context" = "https://graph.microsoft.com/beta/$metadata#deviceManagement/deviceHealthScripts/$entity"
    description      = "New Data" #MAX 1500 .Substring(0, 1500)
}

$Script = Invoke-MgGraphRequest -Uri "/beta/deviceManagement/deviceHealthScripts/9a6cba11-7848-4dc2-bc66-978b83ce567e" -Method PATCH -Body $Body 
