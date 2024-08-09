# Azure


### KQL (Kusto Query Language)
- [https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)
- `//` equals comment

Search for vulnerabilities
````
DeviceTvmSoftwareVulnerabilities
| where CveId in ("CVE-2024-37079", "CVE-2024-37080", "CVE-2024-37081")
````
