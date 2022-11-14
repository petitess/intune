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
Start-Process msiexec.exe -Wait -ArgumentList '/i ImBox+Setup+3.0.0.msi /qn'
 # Get users
$users = Get-ChildItem -Path "C:\Users"

# Loop through users and copy shortcut
$users | ForEach-Object {
    Copy-Item ".\ImBox.lnk" -Destination "C:\Users\$($_.Name)\AppData\Local\Programs\ImBox" -Force -Recurse -ErrorAction Ignore
    Copy-Item ".\ImBox.lnk" -Destination "C:\Users\$($_.Name)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force -Recurse -ErrorAction Ignore
    }
    
}
 
If ($Mode -eq "Uninstall")
 
{
# Avinstallerar...
Start-Process msiexec.exe -Wait -ArgumentList '/x ImBox+Setup+3.0.0.msi /qn'

# Get users
$users = Get-ChildItem -Path "C:\Users"

# Loop through users and delete the file
$users | ForEach-Object {
    Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Programs\ImBox" -Force -Recurse -ErrorAction Ignore
    Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\ImBox.lnk" -Force -Recurse -ErrorAction Ignore
    Remove-Item -Path "C:\Users\$($_.Name)\Desktop\ImBox.lnk" -Force -Recurse -ErrorAction Ignore
    }

}
