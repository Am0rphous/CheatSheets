# Firewalls

### F5 BIG-IP
- Track packets coming in that originates from the Internet and display "X-Forwarded-For" as the attacker's IP. This assumes the log contains wrong from and to IP, e.g. if it's within a private network, and the F5 appliances communicates between each other, masking internet traffic through the "X-Forwarded-For" header.
  - Export data by clicking Share e.g. "Open in Excel"
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
| extend AttackerIP = extract(@"(?i)X-Forwarded-For[:= ]+([0-9a-fA-F:\., ]+)", 1, RawMessage)
| project TimeGenerated, AttackerIP, RawMessage
| order by TimeGenerated asc 
```
- Summarize all the attacking IPs between a certain time. Change `datetime` below!
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
  | where TimeGenerated between  (datetime(2026-09-06 09:33:30) .. datetime(2026-09-06 09:40:00))
  | where RawMessage contains "X-Forwarded-For"
  | extend XFF = extract(
      @"(?i)X-Forwarded-For[:= ]+([0-9a-fA-F:\., ]+)",
      1,
      RawMessage
  )
  | extend XFF = trim(@"[ ,]+", XFF)
  | where isnotempty(XFF)
  | summarize
      NumberOfHits=count(),
      First_observation=min(TimeGenerated),
      Last_observation=max(TimeGenerated),
      Raw_log=take_any(RawMessage)
      by Attacker=XFF
  | order by NumberOfHits desc
  ```
