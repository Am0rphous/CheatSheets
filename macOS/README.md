## MacOS

#### Analytics
- [Opt out of sharing iCloud analytics](https://www.imore.com/how-opt-out-sharing-icloud-analytics-mac)
- To see and open CrashReporter config file
````powershell
nano  /Library/Application\ Support/CrashReporter/SubmitDiagInfo.config
````

#### Brew Package manager
````
brew install cask               #deals with Graphical User Interface (GUI) 
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

#### Disk
````
sudo dd if=~/Downloads/Ubuntu20.04.iso of=/dev/disk5 bs=1m
diskutil list
diskutil eject /dev/disk5
diskutil eraseDisk exFAT MyUSBName /dev/disk4
diskutil eraseDisk JHFS+ CleanDrive /dev/disk1
diskutil unmount /dev/disk4
````

#### Networking commands
````
sudo airportd en0 info
sudo airportd en0 sniff 1
sudo airportd scan                                   #scans for WiFi networks and prints results. Requires sudo.
sudo netstat -ap tcp
sudo netstat -anvp tcp | awk 'NR<3 || /LISTEN/'      #shows sweet list of listening ports
sudo lsof -PiTCP -sTCP:LISTEN
sudo lsof -Pn -i4
sudo lsof -Pn -i4 | grep LISTEN
sudo tcpdump -Ii en0
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

#### Tips and Tricks
````
shift+command+3           #take screenshot of entire screen
shift+command+4           #select area with the mouse to take a screenshot
shift+command+5           #select area with the mouse, press enter to start recording
shift+command+6           #screenshot the touchbar

````


