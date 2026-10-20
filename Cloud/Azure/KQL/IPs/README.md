# IP-Addresses

##### List 10 events containing network traffic to two IPs
```kql
DeviceEvents
| where RemoteIP contains "1.1.1.1" or RemoteIP contains "8.8.8.8"
| project Timestamp, DeviceName, RemoteIP, ActionType, AdditionalFields
| take 10
```
##### Hunt for activity with these 4 IPs
```kql
DeviceNetworkEvents
| where TimeGenerated > ago(90d)
| where LocalIP in ("1.1.1.1", "2.2.2.2", "3.3.3.3", "4.4.4.4")
    or RemoteIP in ("1.1.1.1", "2.2.2.2", "3.3.3.3", "4.4.4.4")
| order by TimeGenerated desc

//Another example
union isfuzzy=true
(
    CommonSecurityLog
    | where TimeGenerated > ago(90d)
    | where SourceIP in ("1.1.1.1", "2.2.2.2", "3.3.3.3", "4.4.4.4")
        or DestinationIP in ("1.1.1.1", "2.2.2.2", "3.3.3.3", "4.4.4.4"))
    | project TimeGenerated, LogType="Firewall", DeviceName=tostring(DeviceName),
              SourceIP=tostring(SourceIP), SourcePort=tostring(SourcePort),
              DestinationIP=tostring(DestinationIP), DestinationPort=tostring(DestinationPort),
              Protocol=tostring(Protocol), Action=tostring(DeviceAction),
              Details=tostring(Activity)
),
(
    DeviceNetworkEvents
    | where TimeGenerated > ago(90d)
    | where LocalIP in ("1.1.1.1", "2.2.2.2", "3.3.3.3", "4.4.4.4")
        or RemoteIP in ("1.1.1.1", "2.2.2.2", "3.3.3.3", "4.4.4.4")
    | project TimeGenerated, LogType="Endepunkt", DeviceName=tostring(DeviceName),
              SourceIP=tostring(LocalIP), SourcePort=tostring(LocalPort),
              DestinationIP=tostring(RemoteIP), DestinationPort=tostring(RemotePort),
              Protocol=tostring(Protocol), Action=tostring(ActionType),
              Details=tostring(InitiatingProcessFileName)
)
| order by TimeGenerated desc
```

