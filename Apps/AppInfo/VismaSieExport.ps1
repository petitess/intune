Param(
[Parameter(Mandatory=$true)]
[ValidateSet("Install", "Uninstall")]
[String[]]
$Mode
)

## För att installera:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Install 

## För att avinstallera:
## powershell.exe -ExecutionPolicy Bypass -file Install.ps1 -Mode Uninstall 


If ($Mode -eq "Install")
 
{
# Installerar...
Start-Process msiexec.exe -Wait -ArgumentList '/i SieSetup.msi  /qn'
 # Get users
$users = Get-ChildItem -Path "C:\Users"

# Loop through users and copy shortcut
$users | ForEach-Object {
    Copy-Item ".\SieExport.lnk" -Destination "C:\Users\Public\Desktop" -Force -Recurse -ErrorAction Ignore
    Copy-Item ".\SieExport.lnk" -Destination "C:\Users\$($_.Name)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force -Recurse -ErrorAction Ignore
    #Copy-Item ".\SieExport.lnk" -Destination "C:\Users\$($_.Name)\Desktop\SieExport.lnk" -Force -Recurse -ErrorAction Ignore
    }
    
}
 
If ($Mode -eq "Uninstall")
 
{
# Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x SieSetup.msi /qn'

# Get users
$users = Get-ChildItem -Path "C:\Users"

# Loop through users and delete the file
$users | ForEach-Object {
#    Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Programs\SieExport" -Force -Recurse -ErrorAction Ignore
    Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\SieExport.lnk" -Force -Recurse -ErrorAction Ignore
    Remove-Item -Path "C:\Users\$($_.Name)\Desktop\SieExport.lnk" -Force -Recurse -ErrorAction Ignore
    }

}
