# Network Equipment

### Mikrotik
```kql
# Check for various names:
DeviceInfo
| where DeviceName contains "mikrotik"
    or DeviceName contains "routeros"
    or OSPlatform contains "routeros"
    or MachineGroup contains "router"
| project Timestamp, DeviceId, DeviceName, OSPlatform, OSVersion,
          OnboardingStatus, SensorHealthState, MachineGroup
| order by Timestamp desc

# Any network adapter vendors?
DeviceNetworkInfo
| where NetworkAdapterVendor contains  "mikrotik"
    or NetworkAdapterVendor contains  "routerboard.com"
| summarize arg_max(Timestamp, *) by DeviceName
| sort by DeviceName asc

# Search Mikrotik MAC address equipment - sort on unique Device names
DeviceNetworkInfo
| extend Mac = replace_regex(toupper(tostring(MacAddress)), @"[^0-9A-F]", "")
| extend OUI = toupper(substring(Mac, 0, 6))
| where OUI in (
    "4C5E0C",
    "18FD74",
    "2CC81B",
    "488F5A",
    "64D154",
    "6C3B6B",
    "B869F4"
)
| summarize arg_max(Timestamp, *) by DeviceName
| sort by DeviceName asc

```
