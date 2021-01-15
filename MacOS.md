## MacOS

#### Disk
````
diskutil list
diskutil eraseDisk exFAT MyUSBName /dev/disk4
diskutil eraseDisk JHFS+ CleanDrive /dev/disk1
diskutil unmount /dev/disk4
````

#### Networking commands
````
netstat -ap tcp
sudo netstat -anvp tcp | awk 'NR<3 || /LISTEN/'      #Shows sweet list of listening ports
sudo lsof -PiTCP -sTCP:LISTEN
lsof -Pn -i4
lsof -Pn -i4 | grep LISTEN
````

#### Package manager

Brew

````
brew install cask               # deals with Graphical User Interface (GUI) 
brew update
brew outdated
brew upgrade
brew upgrade [package name]
brew search [package name]
brew install tor
brew cask uninstall tor
brew cleanup
brew info tor
brew services list
brew services start tor
brew services restart tor|
````

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




