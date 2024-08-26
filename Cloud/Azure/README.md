# Azure

- Ensure you have put up a default startup directory. If not, you will be redirected to the last tenant you logged into. This is problematic if settings require you to use whitelisted IPs or compliant devices (VDI).
- To fix it click your username -> Switch directory -> and change the "Startup directory" setting. (CTRL+F and search for it if you cant see it)


### KQL (Kusto Query Language)
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


### Detection rules
- [L4J/ Log4Shell & Hermeticwiper](https://github.com/stripesoc/detections)
