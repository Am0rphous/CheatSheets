# Exfiltration

```kql
// AppData\Local\Microsoft\Edge\User Data\Default\Login Data/Desired access:FILE_READ_DATA, FILE_READ_EA, FILE_READ_ATTRIBUTES, READ_CONTROL, SYNCHRONIZE
// logins.json/Desired access:FILE_READ_DATA, FILE_READ_EA, FILE_READ_ATTRIBUTES, READ_CONTROL, SYNCHRONIZE
// key4.db/Desired access:FILE_READ_DATA, FILE_READ_EA, FILE_READ_ATTRIBUTES, READ_CONTROL, SYNCHRONIZE

// Use of these?
curl.exe
smartscreen.exe -Embedding

// Action Type - any of these?
SuspiciousProcessDataExfiltration
ProcessRemoteCodeInjected
AntivirusDetection 
```
