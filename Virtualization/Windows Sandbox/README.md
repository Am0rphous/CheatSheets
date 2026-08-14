# Windows Sandbox

- https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file#networking
- https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-sample-configuration
- https://github.com/flexxxxer/WindowsSandbox-ConfigsAndScripts

#### tools
- https://www.zaproxy.org/download/ (winget/scoop)
#### Wsb profile
Save as `.wsb` file
```xml
<Configuration>
  <MemoryInMB>2048</MemoryInMB>
  <VGpu>Enable</VGpu>
  <Networking>Enable</Networking>
  <AudioInput>Enable</AudioInput>
  <ClipboardRedirection>value</ClipboardRedirection>
  <ProtectedClient>Enable</ProtectedClient>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>C:\Users\%username%\SandboxedWindows\SharedToVMs</HostFolder>
      <SandboxFolder>C:\Users\WDAGUtilityAccount\Desktop\SharedToVMs</SandboxFolder>
      <ReadOnly>true</ReadOnly>
    </MappedFolder>
  </MappedFolders>
  <LogonCommand>
    <Command>C:\Users\WDAGUtilityAccount\Desktop\SharedToVMs\script\</Command>
  </LogonCommand>
</Configuration>
```

### script
```powershell
"Enable Developer Mode..." | Write-Output
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Value 1

"Show file extensions..." | Write-Output
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

"Show hidden files..." | Write-Output
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1

powershell.exe "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"

# UniGetUI - https://github.com/Devolutions/UniGetUI#installation
winget install --exact --id Devolutions.UniGetUI --source winget
```
- Dark mode https://github.com/flexxxxer/WindowsSandbox-ConfigsAndScripts/blob/master/Scripts/DarkMode.ps1
