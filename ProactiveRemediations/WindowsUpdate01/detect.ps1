if(Get-Module -ListAvailable -Name PSWindowsUpdate)
{
    Import-Module PSWindowsUpdate
    if (Get-WindowsUpdate) {
        #Updates available
        exit 1
    }
    else {
        #No updates available
        exit 0
    }
}
else{
    Install-Module PSWindowsUpdate -Force
    Import-Module PSWindowsUpdate
    #exit ([int](-not (Get-WindowsUpdate)))
    if (Get-WindowsUpdate) {
        #Updates available
        exit 1
    }
    else {
        #No updates available
        exit 0
    }
}
