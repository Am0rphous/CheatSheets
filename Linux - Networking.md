# Linux Networking

https://gist.github.com/tuxfight3r/9ac030cb0d707bb446c7

https://www.tecmint.com/ss-command-examples-in-linux/
Other: dig, host, ip

### SS - investigate sockets
| Key/Command | Description |
| ----------- | ----------- |
| ss --help | Displays help information |
| man ss | Displays SS's help manual |
| sudo ss -lntup | List TCP/UDP  with Pid's |
| sudo ss -u -a | Display all UDP sockets |
| sudo ss -w -a | Display all raw sockets |
| sudo ss -x -a | Display all Unix sockets |
| sudo ss -4 state closing | See closing sockets on IPv4 |
| sudo ss -o state established '( dport = :smtp or sport = :smtp )' | Display all established SMTP connections |
| sudo ss -o state established '( dport = :http or sport = :http )' | Display all established HTTP connections |
| sudo ss dst 192.168.1.2 | Show all ports connected from remote IP 192.168.1.2 |
| sudo ss dst 192.168.1.10:http | Find connections made by remote IP 192.168.1.10:http to our server | 
| sudo ss -x src /tmp/.X11-unix/* | Find all local processor connected to X Server |

#### SS - filters
| Key/Command | Description |
| ----------- | ----------- |
| sudo ss -4 state FILTER-NAME-HERE | Filters TCP IPv4 |
| sudo ss -6 state FILTER-NAME-HERE | Filters TCP IPv6 |
| established | |
| syn-sent | |
| syn-recv | |
| fin-wait-1 | |
| fin-wait-2 | |
| time-wait | |
| closed | |
| close-wait | |
| last-ack | |
| listen | |
| closing | |
| all | All of the above states |
| connected | All the states except for listen and closed |
| synchronized | All the connected states except for syn-sent |
| bucket | Show states, which are maintained as minisockets, i.e. time-wait and syn-recv |
| big | Opposite to bucket state |

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

#### NetStat
| Key/Command | Description |
| ----------- | ----------- |
| netstat | |
| | |

#### Nmap - Network Mapper
````
nmap -v IP
nmap -v 192.168.1.1/24
nmap 192.168.1.1-254-p22,80 --open -oG - | awk '/22\/open.*80\/open/{print $2}'
nmap --open -p 22,80 192.168.1.1-254 -oG - | grep "/open" | awk '{ print $2 }'
nmap -Pn -oG -p22,80,443,445 - 100.100.100.100 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}'
