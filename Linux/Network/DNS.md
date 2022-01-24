# D N S

- [Known DNS Providers](https://kb.adguard.com/en/general/dns-providers)

Important paths
````powershell
/etc/resolv.conf          #contains e.g. "nameserver 1.1.1.1"
````

Commands
````powershell
host 172.217.21.174
host myserver ns1.dns.com
nslookup google.com
resolvectl status
````

## DNS lookup

### Dig - _DNS lookup utility_
````powershell
dig compass-security.com
dig google.com +short            # return only the IPs associated with a domain
dig domain.com +nocomments       # remove comments in the reply
dig -x 8.8.8.8
dig @8.8.8.8 usa.gov
````
##### DNS Records
- [source](https://www.howtogeek.com/663056/how-to-use-the-dig-command-on-linux/)
````powershell
A Record             # Links the domain to an IP version 4 address.
MX Record            # Mail exchange records direct emails sent to domains to the correct mail server.
NS Record            # Name server records delegate a domain (or subdomain) to a set of DNS servers.
TXT Record           # Text records store text-based information regarding the domain. Typically, they might be used to suppress spoofed or forged email.
SOA Record           #Start of authority records can hold a lot of information about the domain. Here, you can find the primary name server, the responsible party, a timestamp for changes, the frequency of zone refreshes, and a series of time limits for retries and abandons.
TTL                  # Time to live is a setting for each DNS record that specifies how long a DNS precursor server is allowed to cache each DNS query. When that time expires, the data must be refreshed for subsequent requests.
ANY                  # This tells dig to return every type of DNS record it can.
````

## Resolvconf
````powershell
sudo apt install resolvconf
sudo systemctl enable resolvconf.service
sudo systemctl start resolvconf.service
sudo systemctl status resolvconf.service
````
### Set DNS servers in resolv.conf using head file
````powershell
sudo nano /etc/resolvconf/resolv.conf.d/head            #and add e.g. "nameserver 1.1.1.1"
sudo resolvconf --enable-updates
sudo resolvconf -u
````

## systemd-resolved
````powershell
resolvectl domain
resolvectl dns
````
