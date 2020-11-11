# Linux Networking

https://www.tecmint.com/ss-command-examples-in-linux/

### SS - investigate sockets
| Key/Command | Description |
| ----------- | ----------- |
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


#### NetStat
| Key/Command | Description |
| ----------- | ----------- |
| netstat | |
| | |

#### Nmap - Network Mapper
| Key/Command | Description |
| ----------- | ----------- |
| | |
| nmap| network mapper|
| nmap -v 192.168.1.1/24 | scans network |
| | |
