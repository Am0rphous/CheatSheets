# Firewalls

### F5 BIG-IP
- Track packets coming in that originates from the Internet and display "X-Forwarded-For" in an XFF column
```kql
let Logs =
union isfuzzy=true(
    Syslog
    | project TimeGenerated, RawMessage=SyslogMessage
),(
    CommonSecurityLog
    | project TimeGenerated,
              RawMessage=strcat(Message, " ", AdditionalExtensions)
);
Logs
| where TimeGenerated   between (datetime(2026-09-07 07:26:50) .. datetime(2026-09-07 07:35:00))
| where RawMessage contains "X-Forwarded-For"
| extend XFF = extract(@"(?i)X-Forwarded-For[:= ]+([0-9a-fA-F:\., ]+)", 1, RawMessage)
| project TimeGenerated, XFF, RawMessage
| order by TimeGenerated asc 
```
