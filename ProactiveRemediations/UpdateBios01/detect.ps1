$biosversion=Get-HPBIOSVersion
$allowedversions="1.09.00","1.10.01"
exit ([int](-not ($allowedversions -contains $biosversion)))