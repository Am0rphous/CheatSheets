# Email

###### List users received phish or malw in INBOX last 30 days
````
EmailEvents
| where Timestamp > ago(30d)
| where ThreatTypes has "Malware" or ThreatTypes has "Phish"
| where DeliveryLocation contains "inbox"
| project Timestamp, RecipientEmailAddress, Subject, SenderMailFromAddress, SenderDisplayName, SenderMailFromDomain, SenderIPv4, SenderIPv6, DeliveryAction, ThreatTypes
| summarize EmailCount = count() by RecipientEmailAddress
| order by EmailCount desc
````
###### List users received phish or malw last 30 days - includes quarantined!
````
EmailEvents
| where Timestamp > ago(30d)
| where ThreatTypes has "Malware" or ThreatTypes has "Phish"
| project Timestamp, RecipientEmailAddress, Subject, SenderMailFromAddress, SenderDisplayName, SenderMailFromDomain, SenderIPv4, SenderIPv6, DeliveryAction, ThreatTypes
| summarize EmailCount = count() by RecipientEmailAddress
| order by EmailCount desc
````
