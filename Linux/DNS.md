# D N S

- [Known DNS Providers](https://kb.adguard.com/en/general/dns-providers)

Important paths
````powershell
/etc/resolv.conf          #contains e.g. "nameserver 1.1.1.1"
````

Commands
````powershell
nslookup google.com
resolvectl status
````

## resolvconf
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
