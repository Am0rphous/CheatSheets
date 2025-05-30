# Files and hashes

- [cisa malware raport](https://www.cisa.gov/sites/default/files/publications/MAR-10387061.r1.v1.CLEAR.pdf)
- [vulnerable  WinRing0.sys ](https://www.virustotal.com/gui/file/11bd2c9f9e2397c9a16e0990e4ed2cf0679498fe0fd418a3dfdac60b5c160ee5/detection)
````
let Hashes = pack_array(
    "11bd2c9f9e2397c9a16e0990e4ed2cf0679498fe0fd418a3dfdac60b5c160ee5", // WinRing0x64.sys
    "2ffe6509d965413d20ae859a4b4878246119159c368c945a7b466435b4e6e6df", // RuntimeBroker.exe
    "673ebada19e044b1ddb88155ad99188ba403cbb413868877b3ce0af11617bcfb", // wuaucltservice.exe
    "b511c0f45d2a1def0985fa631d1a6df5f754bc7c5f53105cc97c247b97ff0f56"  // config.json
);
DeviceFileEvents
| where DeviceName == "my-device-name-here"
| where SHA256 in (Hashes)
| project Timestamp, DeviceName, SHA256, FileName
````


### Find vulnerable drivers
- [ Detecting Vulnerable Drivers (a.k.a. LOLDrivers) the Right Way Using Microsoft Defender for Endpoint ](https://academy.bluraven.io/blog/detecting-vulnerable-drivers-using-defender-for-endpoint-kql)
````
let LOLDrivers = externaldata (Category:string, KnownVulnerableSamples:dynamic, Verified:string ) [h@"https://www.loldrivers.io/api/drivers.json"]
    with (format=multijson, ingestionMapping='[{"Column":"Category","Properties":{"Path":"$.Category"}},{"Column":"KnownVulnerableSamples","Properties":{"Path":"$.KnownVulnerableSamples"}},{"Column":"Verified","Properties":{"Path":"$.Verified"}}]')
| mv-expand KnownVulnerableSamples
| extend SHA1 = tostring(KnownVulnerableSamples.SHA1), SHA256 = tostring(KnownVulnerableSamples.SHA256);
// you can filter the drivers further based on category or verified status
DeviceEvents
| where ActionType == "DriverLoad"
| join kind=inner (LOLDrivers | where isnotempty(SHA256)) on SHA256
| union (
  DeviceEvents
  | where ActionType == "DriverLoad"
  | join kind=inner (LOLDrivers | where isnotempty(SHA1)) on SHA1
)


````
