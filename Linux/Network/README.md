
# Linux Networking
- [12 ss Command Examples to Monitor Network Connections](https://www.tecmint.com/ss-command-examples-in-linux/)
- [Host-info.sh by Peter-Moller](https://github.com/Peter-Moller/host-info) - Shell script to get various info about a server.
- [Network-info by Peter-Moller](https://github.com/Peter-Moller/network-info) - A bash script for OS X that details information about the network.
- [tcp_flags.txt](https://gist.github.com/tuxfight3r/9ac030cb0d707bb446c7)

<br>

<details> <summary> Essential commands you need to know </summary> <br>
  
````powershell
arp -n                       # show arp cache
ip neigh
curl ifconfig.me             # check your public ip
curl ip.me                   # check your public ip
curl ip.kelp.no              # Check your public ip
ip a l                       # show ip config
ip addr OR ip addr show      # show ip config
ifconfig                     # show ip config
ifconfig wlan0 promisc       # enable promiscuous mode on wlan0
iwconfig
netstat
ping
route
ethtool -s eth0 speed 1000 duplex full autoneg on   # sets 1 Gbit network speed specifically on eth0
````

#### Change IP/MAC address
````powershell
ip link set dev eth0 down
macchanger -m 11:22:33:44:55:66 eth0
ip link set dev eth0 up
````
#### Set Static IP
````powershell
ip addr add 10.10.0.2/24 dev eth0
````

#### Certificates
````powershell
openssl x509 -text -noout -in certificate.crt                 #decrypt cert to a more readable form
openssl s_client -showcerts -connect example.com:443          #read the SSL Certificate information from a remote server
````

#### Curl
````
curl -v -H "user-agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0" 'https://url.com'
````

#### Ipv6
````
ip -6 addr                        #show local listed ipv6 adddresses
ip -6 addr show scope global      #show global reachable addresses
dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com       #test ipv6 vai dns from terminal
dig -t aaaa +short myip.opendns.com @resolver1.opendns.com      #same
curl -6 https://ifconfig.co                                     #test https
curl -6 https://ifconfig.co/ip
curl -6 https://ipv6.icanhazip.com
ssh -6 sshmyip.com                   #test ssh via ipv6
````
</details>

<details> <summary> Ports </summary> <br>
  
- [Open-ports by Peter-Moller](https://github.com/Peter-Moller/open-ports) - A bash-script for OS X and Linux detailing the open network connections to and from a computer.
````powershell
sudo ss -lptn
sudo ss -tulpn
sudo netstat -tulpn
sudo netstat -peanut
sudo netstat -peanut | grep ":80 "
sudo netstat -ltp | egrep -- '-[[:space:]]*$'
sudo netstat --program --numeric-hosts --numeric-ports --extend       # find -inum 152555007
sudo lsof -i TCP:443
sudo lsof -nP -iTCP -sTCP:LISTEN
sudo lsof -i -P -n | grep -i "established"
````

#### NetStat - _Network Statistics_
_command-line tool that displays network connections (both incoming and outgoing), routing tables, and a number of network interface (network interface controller or software-defined network interface) and network protocol statistics. It is available on Unix-like operating systems including OS X, Linux, Solaris, and BSD, and is available on Windows NT-based operating systems including Windows XP, Windows Vista, Windows 7 and Windows 8. [netstat.net](http://netstat.net/)_
````powershell
sudo netstat -tulpn
sudo netstat -peanut
sudo netstat -peanut | grep ":8000 "
#This will give you the number of active connections for each connected IP
sudo netstat -ntu -4 -6 |  awk '/^tcp/{ print $5 }' | sed -r 's/:[0-9]+$//' |  sort | uniq -c | sort -n
````

### SS (Socket Statistics)
- [Examples of Linux ss command to monitor network connections](https://www.binarytides.com/linux-ss-command/)
````powershell
ss --help
man ss                      # Displays SS's help manual
sudo ss -lntup              # List TCP/UDP  with Pid's
sudo ss -u -a               # Display all UDP sockets
sudo ss -w -a               # Display all raw sockets
sudo ss -x -a               # Display all Unix sockets
sudo ss -4 state closing    # See closing sockets on IPv4
sudo ss -o state established '( dport = :smtp or sport = :smtp )'       # Display all established SMTP connections
sudo ss -o state established '( dport = :http or sport = :http )'       # Display all established HTTP connections
sudo ss dst 192.168.1.2                                                 # Show all ports connected from remote IP 192.168.1.2
sudo ss dst 192.168.1.10:http                                           # Find connections made by remote IP 192.168.1.10:http to our server
sudo ss -x src /tmp/.X11-unix/*                                         # Find all local processor connected to X Server
````

#### filters
| Key/Command | Description |
| ----------- | ----------- |
| sudo ss -4 state FILTER-NAME-HERE | Filters TCP IPv4 |
| sudo ss -6 state FILTER-NAME-HERE | Filters TCP IPv6 |
#### Filter list
````powershell
established
syn-sent
syn-recv
fin-wait-1
fin-wait-2
time-wait
closed
close-wait
last-ack
listen
closing
all               # All of the above states
connected         # All the states except for listen and closed
synchronized      # All the connected states except for syn-sent
bucket            # Show states, which are maintained as minisockets, i.e. time-wait and syn-recv
big               # Opposite to bucket state
````

#### SS - filters
| Key/Command | Description |
| ----------- | ----------- |
| sudo ss  sport = :http |
| sudo ss  dport = :http |
| sudo ss  dport \> :1024 |
| sudo ss  sport \> :1024 |
| sudo ss sport \< :32000 |
| sudo ss  sport eq :22 |
| sudo ss  dport != :22 |
| sudo ss  state connected sport = :http |
| sudo ss \( sport = :http or sport = :https \) |
| sudo ss -o state fin-wait-1 \( sport = :http or sport = :https \) dst 192.168.1/24 |


</details>

<details> <summary> Scanning ports </summary> <br>

### Nmap - Network Mapper
````powershell
nmap -v IP
nmap -v 192.168.1.1/24
nmap 192.168.1.1-254-p22,80 --open -oG - | awk '/22\/open.*80\/open/{print $2}'
nmap --open -p 22,80 192.168.1.1-254 -oG - | grep "/open" | awk '{ print $2 }'
nmap -Pn -oG -p22,80,443,445 - 100.100.100.100 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}'
````
</details>

<details> <summary>Block countries in your firewall</summary><br>
- [Free list generator from IP2Location](https://www.ip2location.com/free/visitor-blocker)
- [Download free database](https://download.ip2location.com/lite/)
  
#### My example
- Download the `ASN list`or the `location list` at [https://cable.ayra.ch/ip/](https://cable.ayra.ch/ip/).
- List and save russian ips with `grep Russia asnv4 > list.txt` if you are on Linux/macOS.
- Strip away everything except the IP addresses `grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+' list.txt > only_ip.txt`
- The file **only_ip.txt** now only contains IPv4 addresses.
- When you get the networks of the country you want, lets say 109.108.32.0/21 (a russian network), you could make a simple bash script called "firewall-rules.sh" if you're using Linux and ufw:

````
#!/bin/bash
sudo apt install ufw
sudo ufw enable
sudo ufw deny from 109.108.32.0/21
sudo ufw deny from <next network with netmask here>
sudo ufw deny from <next network with netmask here>
sudo ufw deny from <next network with netmask here>
echo "I am now done running the script. Lets check the status"
ufw status
````
- When you are ready, execute it by simply running `sudo bash firewall-rules.sh`

### Country ASN → IP Range / Prefix Generator by 'abdullahdevrel'
- [Country-asn-to-ip-range-prefix](https://github.com/abdullahdevrel/country-asn-to-ip-range-prefix) - Generating the list of IP ranges or prefixes based on one or more countries or ASNs using IPinfo.io

</details>


<details> <summary> Sniffing network traffic</summary> <br>
  
### TCPDump
- [Tcpdump Examples](https://hackertarget.com/tcpdump-examples)
- [A tcpdump Tutorial with Examples — 50 Ways to Isolate Traffic](https://danielmiessler.com/study/tcpdump/)
````powershell
tcpdump -r capture_file
tcpdump -i eth0 -nn -s0 -v port 80
tcpdump -A -s0 port 80
tcpdump -i eth0 port 636 -X              # show whole package
tcpdump -i eth0 udp
tcpdump -i eth0 proto 17
tcpdump -i eth0 dst 10.10.1.20
tcpdump -i eth0 host 10.10.1.1
tcpdump -qns 0 -A -r blah.pcap           #tcpick -C -yP -r tcp_dump.pcap
tcpdump -i eth0 -s0 -w test.pcap
tcpdump -i eth0 -s0 -l port 80 | grep 'Server:'
tcpdump -i eth0 -s 0  -w tcpdump.pcap host hostA and udp
````
  
#### Remember
````
and = &&
or = ||
not = !
````
  
#### Size
````powershell
tcpdump less 32
tcpdump greater 64
tcpdump <= 128
````

#### TShark (CLI)
````powershell
tshark -h                                           # help
tshark -D                                           # list interfaces
tshark -i eth0                                      # capture traffic on interface 'eth0'
tshark -i eth0 -c 10                                # capture first 10 packets
tshark -i eth0 -c 100 -w capture.pcap               # capture first 100 packets and write them to a file
tshark -i eth0 -f "tcp port 8080"                   # captures packets going to tcp port 8080
tshark -i eth0 -Y 'http.request.methop == "POST"'   #
tshark -r -V capture.pcap                           # reads the capture file with verbose output
tshark -T x                                         # list available output formats. This can be: pdml, ps, psml, json, jsonraw, ek, text, tabs
tshark -r capture.pcap -T text > output.txt         # reads file and converts it to text.
````

### WiresHark (Graphical user interface)
- [Wireshark Cheat Sheet – Commands, Captures, Filters & Shortcuts](https://www.comparitech.com/net-admin/wireshark-cheat-sheet/)

</details>
