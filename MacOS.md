## MacOS

#### Disk
| Key/Command | Description |
| ----------- | ----------- |
| diskutil list | List disks connected to computer |
| diskutil eraseDisk exFAT MyUSBName /dev/disk4 | Formats disk /dev/disk4 with and names it 'MyUSBName' |
| diskutil unmount /dev/disk4 | Unmounts disk /dev/disk4 |

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
|sudo fuser -k 8080/tcp |Kill that process |
| | |
| | |
| | |
| | |

#### Service Management
| Key/Command | Description |
| ----------- | ----------- |
| sudo launchctl list | Lists services |
| sudo launchctl list '|' grep service | Lists services named 'service' |
| sudo launchctl list | grep tor | Lists services named 'tor' |
| | |
| | |
| | |




