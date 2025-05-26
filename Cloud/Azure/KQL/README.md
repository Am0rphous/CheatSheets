# KQL (Kusto Query Language)
- [learn.microsoft.com](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)
- [https://github.com/microsoft/Microsoft-365-Defender-Hunting-Queries](https://github.com/microsoft/Microsoft-365-Defender-Hunting-Queries) - Sample queries for Advanced hunting in Microsoft 365 Defender
- [Must Learn KQL](https://github.com/rod-trent/MustLearnKQL)
- [ Microsoft 365 Defender Advanced Hunting Queries - A Full Guide ](https://ironscales.com/guides/microsoft-365-defender/microsoft-365-defender-advanced-hunting-queries)


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
