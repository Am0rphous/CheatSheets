# D N S

- [Known DNS Providers](https://kb.adguard.com/en/general/dns-providers)

Important paths
````shell
/etc/resolv.conf          # contains e.g. "nameserver 1.1.1.1"
````

Commands
````shell
host 172.217.21.174
host myserver ns1.dns.com
nslookup google.com
resolvectl status
resolvectl query test.example.com
sudo systemd-resolve --flush-caches    # Flush DNS cache when using systemd-resolved

# Access virtual hosts without using DNS. Point hostname to an IP in the file - bypassing dns resolution
sudo        echo "1.2.3.4  example.com" >> /etc/hosts
sudo sh -c "echo '1.2.3.4  domain.com'  >> /etc/hosts"

echo "1.2.3.4 example.com" | sudo tee -a /etc/hosts
sudo sed -i '/\sexample\.com$/d' /etc/hosts && echo "1.2.3.4 example.com" | sudo tee -a /etc/hosts   # Replace 1.2.3.4 and example.com
````

## DNS lookup
### Dig - _DNS lookup utility_
````shell
dig compass-security.com
dig google.com +short            # return only the IPs associated with a domain
dig domain.com +nocomments       # remove comments in the reply
dig -x 8.8.8.8
dig @8.8.8.8 usa.gov
````
##### DNS Records
- [source](https://www.howtogeek.com/663056/how-to-use-the-dig-command-on-linux/)
```shell
A Record             # Links the domain to an IP version 4 address.
MX Record            # Mail exchange records direct emails sent to domains to the correct mail server.
NS Record            # Name server records delegate a domain (or subdomain) to a set of DNS servers.
TXT Record           # Text records store text-based information regarding the domain. Typically, they might be used to suppress spoofed or forged email.
SOA Record           #Start of authority records can hold a lot of information about the domain. Here, you can find the primary name server, the responsible party, a timestamp for changes, the frequency of zone refreshes, and a series of time limits for retries and abandons.
TTL                  # Time to live is a setting for each DNS record that specifies how long a DNS precursor server is allowed to cache each DNS query. When that time expires, the data must be refreshed for subsequent requests.
ANY                  # This tells dig to return every type of DNS record it can.
```

## DNS over TLS (DoT) or DNS over HTTPS (DoH)
```shell
# On your network, check that port 853 is actually reachable, if not the DNS will hang
nmap dns.quad9.net -sV -Pn -p 853
PORT     STATE SERVICE
853/tcp  open  domain

ls -l /etc/resolv.conf   # if points to /run/systemd/resolve/stub-resolv.conf then proceed

# Add this conf into /etc/systemd/resolved.conf
# IPV4 use: DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net

sudo tee /etc/systemd/resolved.conf >/dev/null <<'EOF'
[Resolve]
DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net
FallbackDNS=2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net
DNSOverTLS=yes
DNSSEC=allow-downgrade
EOF

# 4. Make /etc/resolv.conf point to systemd-resolved
sudo ln -sfn /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# 5. Restart DNS resolution
sudo systemctl restart systemd-resolved

# 6. Clear the local DNS cache
sudo resolvectl flush-caches

resolvectl status
bash

resolvectl query example.com
getent hosts example.com
resolvectl dns
resolvectl status
```

## Speed test DNS
````shell
dig yahoo.com | grep time
while true; do dig yahoo.com @8.8.8.8 | grep time; sleep 1; done

sudo snap install namebench-snap
namebench-snap
namebench-snap 1.1.1.1

dnsdiag
dnsping
dnstraceroute
dnseval
dnsperf -s 1.1.1.1 -d myData.txt -c 20 -l 15 -Q 100
dnseval -t A -f serverList.txt -c10 yahoo.com
````

## Resolvconf
````shell
sudo apt install resolvconf
sudo systemctl enable resolvconf.service
sudo systemctl start resolvconf.service
sudo systemctl status resolvconf.service
````
### Set DNS servers in resolv.conf using head file
````shell
sudo nano /etc/resolvconf/resolv.conf.d/head            #and add e.g. "nameserver 1.1.1.1"
sudo resolvconf --enable-updates
sudo resolvconf -u
````

## systemd-resolved
````shell
resolvectl example.com
resolvectl dns
````
