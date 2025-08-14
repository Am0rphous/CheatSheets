## MacOS

Table of content
- [Security](#Security)
  - [Antivirus](#antivirus)
- [Productivity](#Productivity)
- [Networking](#networking)
- [System Maintenance](#system-maintenance)
  - [Disk](#disk)
  - [Files and Folders](#files-and-folders)
  - [Packages](#packages)
  - [Peripherals](#Peripherals)
  - [Processess](#processess)
  - [Services](#services)
  - [Terminal](#terminal)


<br>
<br>

- Analytics:
  - [Opt out of sharing iCloud analytics](https://www.imore.com/how-opt-out-sharing-icloud-analytics-mac)
  - To see and open CrashReporter config file
````shell
nano  /Library/Application\ Support/CrashReporter/SubmitDiagInfo.config
````
- Path to startup items: `/Library/LaunchDaemons/`
- Let the computer print every prime number with 'dc'😂
````
echo '2p3p[dl!d2+s!%0=@l!l^!<#]s#[s/0ds^]s@[p]s&[ddvs^3s!l#x0<&2+l.x]ds.x' | dc
````
- Tips and Tricks
````
shift+command+3           #take screenshot of entire screen
shift+command+4           #select area with the mouse to take a screenshot
shift+command+5           #select area with the mouse, press enter to start recording
shift+command+6           #screenshot the touchbar
````

## Security
### Antivirus
- 2025 - Use [Avira](https://www.avira.com/en/free-antivirus-mac) which is free and a reasonable good alternative.
- Clamav Antivirus - open source, free and multi os support
````
brew install clamav
brew ls clamav |grep clamd                                                        #locate clamd daemon
sudo cp /usr/local/etc/clamav/freshclam.conf.sample /etc/clamav/freshclam.conf
sudo cp /usr/local/etc/clamav/clamd.conf.sample /etc/clamav/clamd.conf
sudo nano /etc/clamav/freshclam.conf                                              #edit config file
sudo freshclam -v
clamscan /tmp --infected                                                          #scan and only list infected files
````
- Fail2ban
  - Config file: `/usr/local/etc/fail2ban`
````
brew install fail2ban
brew services restart fail2ban
````
- Password Generation
  - Command to created 50 random small passwords:
````shell
i=1
while [ $i -le 50 ]
do
  head -c 10 /dev/random | shasum -a 256 | head -c 8
  echo ""
  ((i++))
done
````
## Productivity
````shell
caffeinate                 # stop computer from going to sleep infintine
caffeinate -u -t 3600      # stops computer from going to sleep for 1 hour
cat myfile | pbcopy        # copies content to clipboard :D
qlmanage -p myfile         # quick preview of 'myfile'
````
- [Barrier](https://github.com/debauchee/barrier) - Open-source KVM software - [Troubleshooting](https://github.com/debauchee/barrier/wiki/Troubleshooting#linuxunixmacos-command-line)
  - Problem with SSL such as: `invalid ssl routines pem lib`. Try clicking at the menu bar "Change Settings" and disable/enable SSL -> Reload and start [source](https://github.com/debauchee/barrier/issues/1421).
  - To create certificates yourself
  ````
   cd  /Users/henrik/Library/Application\ Support/barrier/SSL && \
   openssl req -x509 -nodes -days 365 -subj /CN=Barrier -newkey rsa:4096 -keyout Barrier.pem -out Barrier.pem
   #restart the app and click start
  ````
  - On the client: Mark "Client (use another computer's...)" and enter the server IP and click "Start". If it's not working, ping between the IPs and check with "tcpdump port 24800" on botch machines.
### Update $PATH
````
#zsh
echo 'export PATH="${HOME}/Library/Android/sdk/emulator:${HOME}/Library/Android/sdk/platform-tools:${PATH}"' >> ~/.zshrc
source ~/.zshrc

#bash
echo 'export PATH="${HOME}/Library/Android/sdk/emulator:${HOME}/Library/Android/sdk/platform-tools:${PATH}"' >> ~/.bash_profile
source ~/.bash_profile
````

## Networking
- [Network-info by Peter-Moller](https://github.com/Peter-Moller/network-info) - A bash script for OS X that details information about the network.
- [Open-ports by Peter-Moller](https://github.com/Peter-Moller/open-ports) - A bash-script for OS X and Linux detailing the open network connections to and from a computer.
````
sudo lsof -i -P | grep LISTEN    #List listening ports - USE THIS ONE

sudo lsof -PiTCP -s udp:LISTEN   #udp listening ipv4/v6 ports
sudo lsof -PiTCP -s tcp:LISTEN   #ltcp istening ipv4/v6 ports

sudo lsof -Pn -i4               #shows ipv4 UDP/TCP
sudo lsof -Pn -i6               #shows ipv6 UDP/TCP
sudo lsof -Pn -i4 | grep LISTEN  #filter listening ports on ipv4
sudo lsof -Pn -i6 | grep LISTEN  #filter listening ports on ipv6

sudo netstat -anvp udp                           #shows udp ports in use
sudo netstat -anvp tcp | awk 'NR<3 || /LISTEN/'  #shows list of listening ports

sudo tcpdump -Ii en0                        #sniff network traffic on device en0
sudo airportd en0 info
sudo airportd en0 sniff 1
sudo airportd scan                          #scans for WiFi networks and prints results. Requires sudo.
sudo netstat -ap tcp                        #NICE - show open and established connections
````
- DNS
````shell
sudo lsof -iTCP:53 -iUDP:53 -n              # make sure mDNSRespo is running
````
  - Clear the DNS cache
````shell
dscacheutil -flushcache
sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache
````
- Proxychains-ng
Installation
````shell
brew install proxychains-ng       #config: /usr/local/etc/proxychains.conf
proxychains4 curl ifconfig.me
proxychains4 ssh@server.com
proxychains4 nmap ip
````
Be aware: Sometimes you may encounter no IP change, e.g.
````shell
proxychains4 curl ifconfig.me
[proxychains] config file found: /usr/local/etc/proxychains.conf
[proxychains] preloading /usr/local/Cellar/proxychains-ng/4.14/lib/libproxychains4.dylib
(PUBLIC-IP-HERE)  
````
By copying the executable to another location, we resolve this. E.g. `cp /usr/local/bin/wget /tmp/`
Then run:
````shell
proxychains4 /tmp/wget https://google.com
````

## System Maintenance

- Change Hostname
````shell
sudo scutil --set HostName <new host name>
sudo scutil --set LocalHostName <new host name>
sudo scutil --set ComputerName <new name>
dscacheutil -flushcache
reboot
````
- [System-info by Peter-Moller](https://github.com/Peter-Moller/system-info) - Script to give overview of an Operating System.
- Update MacOS from terminal
````shell
softwareupdate --all --install --force
````

### Disk
````
sudo dd if=~/Downloads/Ubuntu20.04.iso of=/dev/disk5 bs=1m
sudo dd if=/dev/disk2s7 bs=4096 | pv -s 28G | sudo dd of=raspbery.img bs=4096    #brew install pv
diskutil list
diskutil eject /dev/disk5
diskutil eraseDisk exFAT MyUSBName /dev/disk4
diskutil eraseDisk JHFS+ CleanDrive /dev/disk1
diskutil unmount /dev/disk4
````

### Files and Folders
- Hiding files and folders
````
hflags hidden my-folder       #hides "my-folder"
chflags nohidden my-folder    #unhides "my-folder"
brew install locate                                                           #installs locate for locating files
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist   #creating a db for locate
locate TorBrowser                                                             #locates anything that matches "TorBrowser"
````

### Packages
- Brew Package Manager
````
brew install cask                # deals with Graphical User Interface (GUI) 
brew update                      # fetch the newest version of Homebrew and all formulae from GitHub using git(1) and perform any necessary migrations.
brew outdated                     # list installed casks and formulae that have an updated version available.
brew upgrade                      # upgrade outdated casks and outdated, unpinned formulae using the same options they were originally installed with, plus any appended brew formula options.
brew upgrade [package name]       # upgrade specific package
brew search [package name]        # searches for package
brew install tor                  # installs package tor
brew cask uninstall tor           # uninstalls tor
brew cleanup
brew info tor                     # lists info about the tor package
brew services list                # list services
brew services start tor           # start tor service
brew services restart tor         # restart tor service
````
### Peripherals
- Listing out:
````
ioreg -p IOUSB -l -w 0      #listing devices
````
### Processess
| Key/Command | Description |
| ----------- | ----------- |
| killall java | Kill all java |
| ps axu | grep "/bin/tor" || Lists processes with "bin/tor" |
| sudo fuser 8080/tcp | Show all process on port 8080 |
|sudo fuser -k 8080/tcp | Kill that process |

### Services
- Launchctl
````shell
sudo launchctl list                         # lists all macOS services
sudo launchctl list | grep service          # lists services named 'service'
sudo launchctl list | grep tor              # lists services named 'tor'
````
### Terminal
- Change crontab to use `nano` with `export VISUAL=nano; crontab -e`
