# IP-Addresses

##### List 10 events containing network traffic to two IPs
````
DeviceEvents
| where RemoteIP contains "1.1.1.1" or RemoteIP contains "8.8.8.8"
| project Timestamp, DeviceName, RemoteIP, ActionType, AdditionalFields
| take 10
````
