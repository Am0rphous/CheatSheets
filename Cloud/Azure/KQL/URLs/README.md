# URLs

##### List devices that has network traffic with whatever.com
```kql
DeviceNetworkEvents   #Or UrlClickEvents
| where RemoteUrl contains "whatever.com"

//1. alternative
| project Timestamp, DeviceName, RemoteUrl, ActionType

//2. alternative
| project InitiatingProcessAccountUpn, RemoteUrl, ActionType, DeviceId, InitiatingProcessFileName

DeviceNetworkEvents
| where RemoteUrl has "whatever.com"
| project Timestamp, DeviceName, RemoteUrl, RemoteIP, LocalIP, InitiatingProcessFileName, InitiatingProcessAccountName
| order by Timestamp desc

//Checking network events towards a russian social media site:
DeviceNetworkEvents
| where RemoteUrl contains "vk.com" or RemoteUrl contains "vkuser." or RemoteUrl contains "vk.ru"

DeviceNetworkEvents
| where RemoteUrl contains "mail.ru"
```

##### Check if device has been in contact with two malicious URLs
```kql
DeviceEvents
| where DeviceName contains "MyPersonalComputerName"
| where RemoteUrl contains "malicious.url.com" or RemoteUrl contains "mailicous2.url.com"

//2. alternative
| project InitiatingProcessAccountUpn, RemoteUrl, ActionType, DeviceId, InitiatingProcessFileName
```
