## MacOS


#### Network
| Key/Command | Description |
| ----------- | ----------- |
| | |
| netstat | |
| | |
| ss| |
| nmap| network mapper|
| nmap -v 192.168.1.1/24 | scans network |
| | |


#### Package manager
| Key/Command | Description |
| ----------- | ----------- |
| brew install tor | Install tor |
| brew info tor |  Displays info about software |
| brew services list | lists services |
| brew services start tor | starts tor service |
| brew services restart tor| restarts tor service |
| | |
| | |

#### Process management
| Key/Command | Description |
| ----------- | ----------- |
| killall java | Kill all java |
| ps axu | grep "/bin/tor" | Lists processes with "bin/tor" |
| sudo fuser 8080/tcp | Show all process on port 8080 |
| sudo fuser -k 8080/tcp | Kill that process |
| | |
| | |
| | |
| | |

#### Service Management
| Key/Command | Description |
| ----------- | ----------- |
| sudo launchctl list | Lists services |
| sudo launchctl list | grep service | Lists services named 'service' |
| sudo launchctl list | grep tor | Lists services named 'tor' |
| | |
| | |
| | |




