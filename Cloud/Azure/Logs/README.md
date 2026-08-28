# Logs

Check Sentinel (portal.azure.com) -> choose sentinel workspace -> Logs -> query e.g.
```kql
Syslog
| where Computer contains "proxy-vm-123"
| take 15

Syslog
| where Computer contains "test-vm" and SyslogMessage contains "10.0.0.12"
| take 20
```
