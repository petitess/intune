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

If ($Mode -eq "Install") {
  # Installerar...
  
  Copy-Item -Path "G40110" -Destination "C:\Program Files" -Recurse -Force
 
  Start-Process -FilePath "C:\Program Files\G40110\HpFirmwareUpdRec.exe" -ArgumentList "/s /b /r" -Wait

  Restart-Computer -Force
}
 
If ($Mode -eq "Uninstall") {
  # Avinstallerar...

}
