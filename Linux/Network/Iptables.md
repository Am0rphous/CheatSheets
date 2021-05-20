# IP tables

Logging
````powershell
iptables -A INPUT -s 192.168.10.0/24 -j LOG --log-prefix "Testing"
`````

Blocking
````powershell
iptables -A INPUT -s 192.168.10.0/24 -j DROP
`````

Opening port
````powershell
iptables -A INPUT -p tcp --destination-port 22 -m iprange --src-range 192.168.1.100-192.168.1.200 -j ACCEPT  
`````

Removing rules
````powershell
iptables -D INPUT 3
`````

Saving:
````powershell
service iptables save
````
