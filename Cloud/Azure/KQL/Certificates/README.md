# Certificates

###### List certs for site.com wher expiration date is higher than todays date
````
DeviceTvmCertificateInfo
| where FriendlyName contains "site.com"
| where ExpirationDate > now()
````
