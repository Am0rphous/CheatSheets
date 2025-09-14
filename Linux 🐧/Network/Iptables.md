# IP tables


- Test ip + port with netcat `nc -vz 1.1.1.1 443` or `nc -vz 1.1.1.1 80`
- Standard rules are these three
````shell
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
````
- List rules
````shell
iptables -S
iptables -t nat -S

#hm
iptables-legacy -S
iptables-nft -S
````

- Reset your firewall without locking yourself out
````shell
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


Delete all rules
````shell
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
#or this:
iptables -F
````

Log traffic from subnet
````shell
iptables -A INPUT -s 192.168.10.0/24 -j LOG --log-prefix "Testing"
`````

Block traffic from subnet
````shell
iptables -A INPUT -s 192.168.10.0/24 -j DROP
`````

Opening port
````shell
iptables -A INPUT -p tcp --destination-port 22 -m iprange --src-range 192.168.1.100-192.168.1.200 -j ACCEPT  
`````

Removing rules
````shell
iptables -L -n --line-numbers           # List first then
iptables -t nat -L -n --line-numbers    # For NAT 
iptables -D INPUT 3                     # Delete input rule number 3
`````

Saving:
````shell
service iptables save
````
