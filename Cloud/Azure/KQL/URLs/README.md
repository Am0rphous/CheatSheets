# URLs

##### List devices that has network traffic with whatever.com
```kql
DeviceNetworkEvents
| where RemoteUrl contains "whatever.com"

//1. alternative
| project Timestamp, DeviceName, RemoteUrl, ActionType

//2. alternative
| project InitiatingProcessAccountUpn, RemoteUrl, ActionType, DeviceId, InitiatingProcessFileName

DeviceNetworkEvents
| where RemoteUrl has "whatever.com"
| project Timestamp, DeviceName, RemoteUrl, RemoteIP, LocalIP, InitiatingProcessFileName, InitiatingProcessAccountName
| order by Timestamp desc
```

##### Check if device has been in contact with two malicious URLs
```kql
DeviceEvents
| where DeviceName contains "MyPersonalComputerName"
| where RemoteUrl contains "malicious.url.com" or RemoteUrl contains "mailicous2.url.com"

//2. alternative
| project InitiatingProcessAccountUpn, RemoteUrl, ActionType, DeviceId, InitiatingProcessFileName
```
