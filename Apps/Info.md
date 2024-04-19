##### Davinci Resolver
```sql
- extract DaVinci_Resolve_18.6.6_Windows.exe using WinZip
- package the context with IntuneWinAppUtil.exe
- install: msiexec /i "ResolveInstaller.msi" /qn
- uninstall: msiexec /x "{B62C004F-C2D6-41AE-8E4B-005528869599}" /qn
- detection rule: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B62C004F-C2D6-41AE-8E4B-005528869599}
- key path: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B62C004F-C2D6-41AE-8E4B-005528869599}
- value name: DisplayVersion
- detection method: String comparison
- operator: Equals
- value: 3.66.5
```
