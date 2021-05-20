#


````
netstat -nap | grep "@/proc/udevd"      # result should return nothing
````

#### Linux/Ebury - OpenSSH backdoor trojan and credential stealer
- [OPERATION WINDIGO](https://www.welivesecurity.com/wp-content/uploads/2014/03/operation_windigo.pdf)
- [Source](https://ubuntuforums.org/showthread.php?t=2291968)
````
find /lib* -type f -name libns2.so      # should return nothing
ssh -G 2>&1 | grep -e illegal -e unknown -e Gg > /dev/null && echo "System clean" || echo "System infected"
````


## ClamAV
````powershell
sudo apt install clamav clamav-daemon mailutils -y
service clamav-freshclam stop                       #service needs to be stopped before updating
sudo freshclam                                      #updates signatures
sudo wget https://database.clamav.net/daily.cvd     #download latest signature
sudo cp daily.cvd /var/lib/clamav/
service clamav-freshclam restart                    #restart the service after
clamscan --version                                  #shows the version and date of signatures
/var/log/clamav/freshclam.log                       #logfile
sigtool --info /var/lib/clamav/daily.cld
clamscan -r --bell -i /                             # display infected files and ring a bell when found
clamscan -r -i / &                                  #run it as background. Run `jobs` to list it
````

## Rootkit hunting
### Chkrootkit
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
## Process Hunting
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
