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
   
    Start-Process limepro-desktop-10.12.219.exe -Wait -ArgumentList 'LIMELANGUAGE=sv LIMESERVER=SRV253048.ad.almi.se LIMEDATABASE=Lime /quiet'
      

}
 
If ($Mode -eq "Uninstall")
{
    # Avinstallerar...
    Start-Process limepro-desktop-10.12.219.exe -Wait -ArgumentList '/uninstall /quiet'

}
