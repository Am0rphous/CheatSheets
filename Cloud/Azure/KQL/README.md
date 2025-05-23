# KQL (Kusto Query Language)
- [learn.microsoft.com](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)
- [https://github.com/microsoft/Microsoft-365-Defender-Hunting-Queries](https://github.com/microsoft/Microsoft-365-Defender-Hunting-Queries) - Sample queries for Advanced hunting in Microsoft 365 Defender
- [Must Learn KQL](https://github.com/rod-trent/MustLearnKQL)
- [ Microsoft 365 Defender Advanced Hunting Queries - A Full Guide ](https://ironscales.com/guides/microsoft-365-defender/microsoft-365-defender-advanced-hunting-queries)



#### Search for vulnerabilities
````
//first alternative
DeviceTvmSoftwareVulnerabilities | where CveId in ("CVE-2024-37079", "CVE-2024-37080", "CVE-2024-37081")

//second alternative
DeviceTvmSoftwareVulnerabilities
| where CveId in (
    "CVE-2025-24252",
    "CVE-2025-24132",
    "CVE-2025-31202",
    "CVE-2025-24206"
)
| summarize CveIds = make_set(CveId) by DeviceName
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

````
DeviceEvents| where DeviceName contains "MyPersonalComputerName"| where RemoteUrl contains "malicious.url.com" or RemoteUrl contains "mailicous2.url.com"| project InitiatingProcessAccountUpn, RemoteUrl, ActionType, DeviceId, InitiatingProcessFileName
````

finding internet-facing devices
````
DeviceNetworkEvents
| where RemoteIPType == "Public"
| where ActionType == @"InboundConnectionAccepted"
| distinct DeviceName, InitiatingProcessFileName, LocalPort

DeviceNetworkEvents
// Filter on devices that have been scanned
| where ActionType == "InboundInternetScanInspected"
| project IP_Source_ScannerAttempt=LocalIP,Country_Source_ScannerAttempt=tostring(geo_info_from_ip_address(LocalIP).country), PublicScannedIP= RemoteIP,PublicScannedIP_country=tostring(geo_info_from_ip_address(RemoteIP).country), PublicScannedPort= RemotePort,DeviceName
````
