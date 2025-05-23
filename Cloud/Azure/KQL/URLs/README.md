# URLs

##### List devices that has network traffic with whatever.com
````
DeviceNetworkEvents
| where RemoteUrl contains "whatever.com"
| project Timestamp, DeviceName, RemoteUrl, ActionType
````

##### Check if device has been in contact with two malicious URLs
````
DeviceEvents
| where DeviceName contains "MyPersonalComputerName"
| where RemoteUrl contains "malicious.url.com" or RemoteUrl contains "mailicous2.url.com"
| project InitiatingProcessAccountUpn, RemoteUrl, ActionType, DeviceId, InitiatingProcessFileName
````
