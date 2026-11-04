# Software

Check if there is occurence of SoftEther VPN in infra
```kql
DeviceTvmSoftwareInventory
| where SoftwareName contains "softether"
| limit 5     #reduce resource usage. Remove if you want all result
```

Find fortinet stuff
```kql
DeviceTvmSoftwareVulnerabilities
| where tolower(SoftwareVendor) contains "forti"| project TenantId, DeviceName, OSPlatform, SoftwareVendor, SoftwareName, SoftwareVersion, CveId, VulnerabilitySeverityLevel
//| limit 20
```

### WSL / Windows Subsystem for Linux
- https://learn.microsoft.com/en-us/windows/wsl/basic-commands
```kql
// also consider: ProcessCommandLine contains "wsl.exe --install"

// Count unique devices that have run wsl.exe last 90 days
DeviceProcessEvents
| where Timestamp > ago(90d)
| where FileName =~ "wsl.exe"
| summarize by DeviceId
| count 

//How ofen have wsl.exe been observed in total?
DeviceProcessEvents
| where Timestamp > ago(90d)
| where FileName =~ "wsl.exe"
| count 
```
