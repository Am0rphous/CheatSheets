# KQL (Kusto Query Language)
- [learn.microsoft.com](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)

Search for vulnerabilities
````
//comment here
DeviceTvmSoftwareVulnerabilities | where CveId in ("CVE-2024-37079", "CVE-2024-37080", "CVE-2024-37081")
````
List device names affected by a specific vulnerability
````
DeviceTvmSoftwareVulnerabilities | where CveId == "CVE-2024-37079" | distinct DeviceName
````
List all hosts affected by this vulnerability (log4j)
````
DeviceTvmSoftwareVulnerabilities
| where CveId == "CVE-2021-44228"
| project DeviceName, DeviceId, OSPlatform, OSVersion, SoftwareVendor, CveId, VulnerabilitySeverityLevel
````

Find fortinet stuff
````
DeviceTvmSoftwareVulnerabilities
| where tolower(SoftwareVendor) contains "forti"| project TenantId, DeviceName, OSPlatform, SoftwareVendor, SoftwareName, SoftwareVersion, CveId, VulnerabilitySeverityLevel
//| limit 20
````
