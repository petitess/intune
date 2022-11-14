@echo off
msiexec /x "{2CED2865-B03E-4417-8681-3DEF12710763}" /q
copy "%~dp0\templates1.txt" "%USERPROFILE%"
Goto End
:End
exit
