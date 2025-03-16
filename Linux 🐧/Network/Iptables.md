# IP tables


### deleting
- Alternative 1: Reset your firewall without locking yourself out
````
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X
````
- alternative 2
````
iptables-save | awk '/^[*]/ { print $1 } 
                     /^:[A-Z]+ [^-]/ { print $1 " ACCEPT" ; }
                     /COMMIT/ { print $0; }' | iptables-restore

````

Default rules
````
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
````
Delete all rules
````
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
#or this:
iptables -F
````

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
