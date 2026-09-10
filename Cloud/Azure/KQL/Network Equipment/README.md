# Network Equipment

### Firewals
- Search for names containing "fw"
```kql
DeviceInfo
| where DeviceName contains "fw"
| project DeviceName, OSPlatform, DeviceType, LoggedOnUsers, Timestamp
| order by DeviceName asc 

// Names
  "Firebox",
  "SMA100 Appliances",
  "SMA1000 Appliances",
  "SMA1000 appliance",
  "SonicOS",
  "FortiOS",
  "FortiProxy",
  "FortiWeb",
  "DIR-859 Router",
  "Routers",
  "Multiple Routers",
  "RT-AX55 Routers",
  "Small Business RV Series Routers",
  "Vigor Routers",
  "NetScaler",
  "NetScaler ADC",
  "NetScaler Gateway",
  "PAN-OS",
  "ScreenOS",
  "Junos OS",
  "XG Firewall",
  "Connect Secure",
  "Policy Secure",
  "ZTA Gateways",
  "Secure Firewall Adaptive Security Appliance",
  "Secure Firewall Threat Defense"
```
