# Azure


### KQL (Kusto Query Language)
- [learn.microsoft.com](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)

Search for vulnerabilities
````
//comment here
DeviceTvmSoftwareVulnerabilities
| where CveId in ("CVE-2024-37079", "CVE-2024-37080", "CVE-2024-37081")
````
List hosts affected by vulnerability
````
DeviceTvmSoftwareVulnerabilities
| where CveId == "CVE-2024-37079"
| distinct DeviceName
````

### Detection rules
- [L4J/ Log4Shell & Hermeticwiper](https://github.com/stripesoc/detections)
