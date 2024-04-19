#### Davinci Resolver
- extract DaVinci_Resolve_18.6.6_Windows.exe using WinZip
- package the context with IntuneWinAppUtil.exe
- install: msiexec /i "ResolveInstaller.msi" /qn
- uninstall: msiexec /x "{B62C004F-C2D6-41AE-8E4B-005528869599}" /qn
- detaction rule: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B62C004F-C2D6-41AE-8E4B-005528869599}
