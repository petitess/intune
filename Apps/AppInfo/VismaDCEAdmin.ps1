Param(
    [Parameter(Mandatory = $true)]
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
    Start-Process msiexec.exe -Wait -ArgumentList '/i ALMI_PROD_DCEAdmin1200.msi /qn'

    Copy-Item "DceAdmin.exe.config" -Destination "C:\Program Files (x86)\Visma\DCE Administrator" -Force -Recurse -ErrorAction Ignore

    $ACL = Get-Acl "C:\Program Files (x86)\Visma\DCE Administrator\"
    $Ar = New-Object System.Security.AccessControl.FileSystemAccessRule ("Användare", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

    $ACL.SetAccessRule($Ar)
    Set-Acl "C:\Program Files (x86)\Visma\DCE Administrator\" $ACL
}
 
If ($Mode -eq "Uninstall")
{
    # Avinstallerar...
    Start-Process msiexec.exe -Wait -ArgumentList '/x ALMI_PROD_DCEAdmin1200.msi /qn'

}
