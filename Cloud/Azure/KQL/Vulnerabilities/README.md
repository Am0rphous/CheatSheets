# Vulnerabilities

### List Windows Servers with missing KBs/recommended updates
<details> <h2> <summary> Ex </h2></summary> <br>
  
```kql
```

</details>

### Search for multiple CVEs - two formats
```kql
DeviceTvmSoftwareVulnerabilities | where CveId in ("CVE-2024-37079", "CVE-2024-37080", "CVE-2024-37081") //first format

DeviceTvmSoftwareVulnerabilities //second format
| where CveId in (
    "CVE-2025-24252",
    "CVE-2025-24132",
    "CVE-2025-31202",
    "CVE-2025-24206" )
| summarize CveIds = make_set(CveId) by DeviceName
```
### List devices affected by CVE
```kql
DeviceTvmSoftwareVulnerabilities | where CveId == "CVE-2024-37079"

| distinct DeviceName   //first alternative

//second alternative
| project DeviceName, DeviceId, OSPlatform, OSVersion, SoftwareVendor, CveId, VulnerabilitySeverityLevel
```
### List vulnerable software, also show if available updates (may give a lot of results)
```kql
DeviceTvmSoftwareVulnerabilities
| where SoftwareName contains "oracle" or SoftwareVendor contains "apple"
| distinct DeviceName, OSPlatform, SoftwareVendor, SoftwareName, SoftwareVersion, RecommendedSecurityUpdate, RecommendedSecurityUpdateId
```
