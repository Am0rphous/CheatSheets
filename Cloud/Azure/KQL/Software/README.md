# Software

Check if there is occurence of SoftEther VPN in infra
````
DeviceTvmSoftwareInventory
| where SoftwareName contains "softether"
| limit 5     #reduce resource usage. Remove if you want all result
````

Find fortinet stuff
````
DeviceTvmSoftwareVulnerabilities
| where tolower(SoftwareVendor) contains "forti"| project TenantId, DeviceName, OSPlatform, SoftwareVendor, SoftwareName, SoftwareVersion, CveId, VulnerabilitySeverityLevel
//| limit 20
````
