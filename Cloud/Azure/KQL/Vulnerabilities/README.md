# Vulnerabilities

<details> <summary> <h3>List Windows Servers with missing KBs/recommended updates (Expand)</h3></summary>
  
```kql
DeviceTvmSoftwareVulnerabilities
| where OSPlatform startswith "WindowsServer"
| where isnotempty(RecommendedSecurityUpdateId)
| join kind=leftouter (
    DeviceTvmSoftwareVulnerabilitiesKB
    | project CveId, CvssScore
) on CveId
| summarize
    MissingTheseUpdates = make_set(
        pack(
            "KB/ID", RecommendedSecurityUpdateId,
            "Update", RecommendedSecurityUpdate,
            "CVE", CveId,
            "CVSS", CvssScore
        )
    )
    by DeviceId, DeviceName, OSPlatform
| sort by DeviceName asc
```
Result looks like
```kql
2734982fdf82f8f828s88f8f8888s8s8s8s88222    MyServer02    WindowsServer2016    [{"KB/ID":"5126868","Update":"October 2026 Security Updates","CVE":"CVE-2026-1 ...
```
</details>

<details> <summary> <h3>List every non-Windows Servers (unix/linux) with missing KBs/recommended updates (Expand)</h3></summary>
```kql
DeviceTvmSoftwareVulnerabilities
| where OSPlatform !startswith  "WindowsServer" and OSPlatform !startswith "Windows1"
| where isnotempty(RecommendedSecurityUpdateId)
| join kind=leftouter (
    DeviceTvmSoftwareVulnerabilitiesKB
    | project CveId, CvssScore
) on CveId
| summarize
    MissingTheseUpdates = make_set(
        pack(
            "KB/ID", RecommendedSecurityUpdateId,
            "Update", RecommendedSecurityUpdate,
            "CVE", CveId,
            "CVSS", CvssScore
        )
    )
    by DeviceId, DeviceName, OSPlatform
| sort by DeviceName asc
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
