#


````
debsums                                 #check the MD5 sums of installed Debian packages
netstat -nap | grep "@/proc/udevd"      # result should return nothing
find /path-of-www -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r           # Examine recently modified files on the server
find /var/www -name "*.php" -exec grep -l "eval(" {} \;                      # Search for common malware strings 
````

### Linux/Ebury - OpenSSH backdoor trojan and credential stealer
- [OPERATION WINDIGO](https://www.welivesecurity.com/wp-content/uploads/2014/03/operation_windigo.pdf)
- [Operation Windigo: Linux malware campaign that infected 500,000 Computers Worldwide](https://thehackernews.com/2014/03/operation-windigo-linux-malware.html)
- [Source](https://ubuntuforums.org/showthread.php?t=2291968)
````
find /lib* -type f -name libns2.so      # should return nothing
ssh -G 2>&1 | grep -e illegal -e unknown -e Gg > /dev/null && echo "System clean" || echo "System infected"
````


### ClamAV
- [Download](https://www.clamav.net/downloads)
- [Installation on Debian and Ubuntu Linux Distributions](https://docs.clamav.net/manual/Installing/Steps/Steps-Debian-Ubuntu.html)
````powershell
sudo apt install clamav clamav-daemon mailutils -y
sudo service clamav-freshclam stop                  # service needs to be stopped before updating
sudo freshclam                                      # updates signatures
sudo wget https://database.clamav.net/daily.cvd     # download latest signature
sudo cp daily.cvd /var/lib/clamav/
sudo service clamav-freshclam restart               # restart the service after
clamscan --version                                  # shows the version and date of signatures
/var/log/clamav/freshclam.log                       # logfile
sigtool --info /var/lib/clamav/daily.cld
sudo clamscan -r --bell -i /                        # display infected files and ring a bell when found
sudo clamscan -r -i /                               # foreround
sudo clamscan -r -i / &                             # run it as background. Run `jobs` to list it
````

### Maldet - Linux Malware Detect
- [linux-malware-detect](https://github.com/rfxn/linux-malware-detect) -  Linux Malware Detection (LMD)
````powershell
wget https://github.com/rfxn/linux-malware-detect/archive/refs/tags/1.6.4.zip
unzip 1.6.4.zip
cd linux-malware-detect-1.6.4
bash install.sh
maldet -a
````

### Rootkit hunting
#### Chkrootkit
````powershell
wget ftp://ftp.pangeia.com.br/pub/seg/pac/chkrootkit.tar.gz
tar -xvf chkrootkit.tar.gz
cd chkrootkit-0.54/
make sense
./chkrootkit
./chkrootkit -r /mnt/                         # check this folder and it's sub folders
./chkrootkit -p /cdrom/bin:/floppy/mybin      # adds binary paths
./chkrootkit -x | more
./chkrootkit -x | egrep '^/'                  # pathnames inside system commands
````
### Rkhunter
Download latest version from [rkhunter.sourceforge.net](http://rkhunter.sourceforge.net)
````powershell
tar -xvf rkhunter-1.4.6.tar.gz 
cd rkhunter-1.4.6
/installer.sh --layout default --install
/usr/local/bin/rkhunter --update              #update
/usr/local/bin/rkhunter --propupd             #update
rkhunter --check                              #manual check
/var/log/rkhunter.log                         #log file
````
#### You might want to change these in `/etc/rkhunter.conf`

````powershell
MIRRORS_MODE=1          to this -->   MIRRORS_MODE=0
UPDATE_MIRRORS=0        to this -->   PDATE_MIRRORS=1
WEB_CMD="/bin/false"    to this -->   WEB_CMD=""
rkhunter --update
````
#### Usage
````powershell
sudo rkhunter --check --enable all --disable none
sudo rkhunter --update
sudo rkhunter --check
sudo rkhunter --check --bindir /mnt/safe           # tells rkhunter which directories to look in to find the various commands it requires:
````
### Process Hunting
- [launchpad.net/unhide.rb](https://launchpad.net/unhide.rb) - Unhide.rb is a tool that attempts to find processes hidden by rootkits. It does that by scanning for processes in many different ways, and then lists processes found through some means but not through others.
Install
````powershell
sudo apt install unhide unhide.rb
````
Usage unhide.rb
````powershell
sudo unhide.rb       # no need for options
````
Usage unhide
````powershell
sudo unhide test-name
sudo unhide brute              # test can be: brute, proc, procall, procfs, quick, reverse, sys
````
Unhide also comes with `unhide-tcp` which naturally is used to find hidden TCP/UDP ports.
````powershell
sudo  unhide-tcp
````
