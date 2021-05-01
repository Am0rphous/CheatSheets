# IP tables

Logging
````powershell
iptables -A INPUT -s 192.168.10.0/24 -j LOG --log-prefix "Testing"
`````

Blocking
````powershell
iptables -A INPUT -s 192.168.10.0/24 -j DROP
`````

Removing rules
````powershell
iptables -D INPUT 3
`````

Saving:
````powershell
service iptables save
````
