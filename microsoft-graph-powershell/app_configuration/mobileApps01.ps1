# Connect-MgGraph -Identity
#DeviceManagementConfiguration.Read.All DeviceManagementApps.Read.All
$Apps = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps").value
$App = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=displayName eq 'Caesar Document ActiveX 7.0.2.0 TLS'").value

Write-Output "Found $($Apps.Count) apps"

$headersITG = @{
    "x-api-key"    = "ITG.123.abcd"
    "Content-Type" = "application/vnd.api+json"
}

$ExistingDocuments = (Invoke-RestMethod -Method GET -Uri "https://api.eu.itglue.com/organizations/1234567890123456/relationships/documents?filter[document_folder_id]=1994796736495784&page[size]=300" -Headers $headersITG).data

Write-Output "Found $($ExistingDocuments.Count) documents"

$data = @()
$ExistingDocuments | ForEach-Object {
    $data += @{
        type       = "documents"
        attributes = @{
            organization_id    = "1234567890123456"
            id                 = $_.id
            document_folder_id = "1994796736495784"
        }
    }
}
if ($null -ne $Apps -and $null -ne $ExistingDocuments) {
    
    $bodyRemove = @{
        data = $data
    } | ConvertTo-Json -Depth 100

    $Remove = (Invoke-RestMethod -Method Delete -Uri "https://api.eu.itglue.com/organizations/1234567890123456/relationships/documents" -Headers $headersITG  -Body $bodyRemove)
    if ($null -ne $Remove) {
        Write-Output "Removed documents"
    }
}
else {
    Write-Output "Could not recieve intune apps or folder Install is empty"
    return
}

$Apps | ForEach-Object {
    $App = $_
    Write-Warning "Creating document for: $($App.displayName)"

    $bodyNewDoc = @{
        data = @{
            type       = "documents"
            attributes = @{
                organization_id    = "1234567890123456"
                name               = $App.displayName
                public             = $True
                is_uploaded        = $False
                document_folder_id = "1994796736495784"
            }
        }
    } | ConvertTo-Json -Depth 100


    $New = (Invoke-RestMethod -Method Post -Uri "https://api.eu.itglue.com/organizations/1234567890123456/relationships/documents" -Headers $headersITG -Body $bodyNewDoc).data

    $AppInfo = @"
<div>Name: $($App.displayName)</div>
<div>Version: $($App.displayVersion)</div>
<div>Publisher: $($App.publisher)</div>
<div>Category: $($App.category)</div>
"@

    $Program = @"
<div>Install Command: $($App.installCommandLine)</div>
<div>Uninstall Command: $($App.uninstallCommandLine)</div>
<div>Allow Available Uninstall: $($App.allowAvailableUninstall)</div>
<div>Max Run Time (Minutes): $($App.installExperience.maxRunTimeInMinutes)</div>
<div>deviceRestartBehavior: $($App.installExperience.deviceRestartBehavior)</div>
"@

    $DetectionRules = @"
<div>keyPath: $($App.detectionRules.keyPath)</div>
<div>detectionType: $($App.detectionRules.detectionType)</div>
<div>operator: $($App.detectionRules.operator)</div>
<div>valueName: $($App.detectionRules.valueName)</div>
<div>detectionValue: $($App.detectionRules.detectionValue)</div>
"@

    $Requirements = @"
<div>minimumSupportedWindowsRelease: $($App.minimumSupportedWindowsRelease)</div>
<div>applicableArchitectures: $($App.applicableArchitectures)</div>
<div>physicalMemoryInMB: $($App.requirements.physicalMemoryInMB)</div>
<div>processorArchitecture: $($App.requirements.processorArchitecture)</div>
"@

    $Dependencies = @"
<div>dependentAppCount: $($App.dependentAppCount)</div>
<div>supersedingAppCount: $($App.supersedingAppCount)</div>
"@

    $Other = @"
<div>Description: $($App.description)</div>
<div>Notes: $($App.notes)</div>
"@

    $AssignmentInfo = @()
    $Assignments = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$($App.id)/assignments").value
    $Assignments | ForEach-Object {

        try {
            $Group = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/groups/$($_.target.groupId)").displayName
            $AssignmentInfo += @"
    <div>
    <table>
        <tbody>
        <tr>
            <td>Group Name<br type="_moz"></td>
            <td>$Group<br type="_moz"></td>
        </tr>
        <tr>
            <td>Group Id<br type="_moz"></td>
            <td>$($_.target.groupId)<br type="_moz"></td>
        </tr>
        <tr>
            <td>Group Mode<br type="_moz"></td>
            <td>$($_.intent)<br type="_moz"></td>
        </tr>
        </tbody>
    </table>
  <div><br type="_moz"></div>
</div>
"@
        }
        catch {
            Write-Output "Group not found: $($_.Exception.Message). $($_.Exception.InnerException.Message). $($_.Exception.StackTrace)"
        }
    }

    $sections = @(
        @{
            resource_type = "Document::Text"
            content       = "<p>$($AssignmentInfo)</p>"
        }
        @{
            resource_type = "Document::Heading"
            content       = "Assignments"
            level         = 2
        }
        @{
            resource_type = "Document::Text"
            content       = "<p>$($Other)</p>"
        }
        @{
            resource_type = "Document::Heading"
            content       = "Other"
            level         = 2
        }
        @{
            resource_type = "Document::Text"
            content       = "<p>$($Dependencies)</p>"
        }
        @{
            resource_type = "Document::Heading"
            content       = "Dependencies"
            level         = 2
        }
        @{
            resource_type = "Document::Text"
            content       = "<p>$($Requirements)</p>"
        }
        @{
            resource_type = "Document::Heading"
            content       = "Requirements"
            level         = 2
        }
        @{
            resource_type = "Document::Text"
            content       = "<p>$($DetectionRules)</p>"
        }
        @{
            resource_type = "Document::Heading"
            content       = "Detection Rules"
            level         = 2
        }
        @{
            resource_type = "Document::Text"
            content       = "<p>$($Program)</p>"
        }
        @{
            resource_type = "Document::Heading"
            content       = "Program"
            level         = 2
        }
        @{
            resource_type = "Document::Text"
            content       = "<p>$($AppInfo)</p>"
        }
        @{
            resource_type = "Document::Heading"
            content       = "App Information"
            level         = 2
        }
        @{
            resource_type = "Document::Text"
            content       = "Uploaded by runbook $(Get-Date -Format "yyyy-MM-dd HH:mm")"
        }
    )

    $sections | ForEach-Object {
        Write-Output "Section show: $($_.content)" -Verbose -Debug
        $bodyText = @{
            data = @{
                type       = "document-sections"
                attributes = @{
                    "resource-type" = $_.resource_type
                    content         = $_.content
                    level           = $_.level
                }
            }
        } | ConvertTo-Json -Depth 100


        try {
            $Section = (Invoke-RestMethod -Method Post -Uri "https://api.eu.itglue.com/documents/$($New.id)/relationships/sections" -Headers $headersITG -Body $bodyText).data
            Write-Output "Section added."
        }
        catch {
            Write-Output "Section failed: $($_.Exception.Message). $($_.Exception.InnerException.Message). $($_.Exception.StackTrace)"
        }
    }

    try {
        $Publish = (Invoke-RestMethod -Method Patch -Uri "https://api.eu.itglue.com/organizations/1234567890123456/relationships/documents/$($New.id)/publish" -Headers $headersITG)
    }
    catch {
        Write-Output "Publishing failed: $($_.Exception.Message). $($_.Exception.InnerException.Message). $($_.Exception.StackTrace)"
    }
}

