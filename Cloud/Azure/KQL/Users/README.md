# Users

#### Create visual graph of sign-ins for user mike@test.com
```kql
SigninLogs
| where TimeGenerated >= ago(30d)
| where UserPrincipalName has "mike@test.com"
| extend LocalTime = datetime_utc_to_local(TimeGenerated, "Europe/London")
| extend LocalHour = hourofday(LocalTime)
| where LocalHour between (0 .. 24)
| summarize SignInCount = count() by LocalHour
| order by LocalHour asc
| render columnchart with (
    title = "Morning Sign-ins by Local Time",
    xtitle = "Local Hour",
    ytitle = "Sign-in Count"
)
```
