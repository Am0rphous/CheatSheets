## MacOS

#### Analytics
- [Opt out of sharing iCloud analytics](https://www.imore.com/how-opt-out-sharing-icloud-analytics-mac)
- To see and open CrashReporter config file
````powershell
nano  /Library/Application\ Support/CrashReporter/SubmitDiagInfo.config
````

#### Brew Package manager
````
brew install cask                # deals with Graphical User Interface (GUI) 
brew update                      # fetch the newest version of Homebrew and all formulae from GitHub using git(1) and perform any necessary migrations.
brew outdated                    # list installed casks and formulae that have an updated version available.
brew upgrade                     # upgrade outdated casks and outdated, unpinned formulae using the same options they were originally installed with, plus any appended brew formula options.
brew upgrade [package name]      # upgrade specific package
brew search [package name]       # searches for package
brew install tor                 # installs package tor
brew cask uninstall tor          # uninstalls tor
brew cleanup
brew info tor                    #lists info about the tor package
brew services list
brew services start tor          # start tor service
brew services restart tor        # restart tor service
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
- [Open-ports by Peter-Moller](https://github.com/Peter-Moller/open-ports) - A bash-script for OS X and Linux detailing the open network connections to and from a computer.

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

#### Service Management
| Key/Command | Description |
| ----------- | ----------- |
| sudo launchctl list | Lists all macOS services |
| sudo launchctl list '|' grep service | Lists services named 'service' |
| sudo launchctl list | grep tor | Lists services named 'tor' |

#### Tips and Tricks
````
shift+command+3           #take screenshot of entire screen
shift+command+4           #select area with the mouse to take a screenshot
shift+command+5           #select area with the mouse, press enter to start recording
shift+command+6           #screenshot the touchbar

````


