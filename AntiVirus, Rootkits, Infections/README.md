#


````
netstat -nap | grep "@/proc/udevd"
````


- [Source](https://ubuntuforums.org/showthread.php?t=2291968)
````
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
You might want to change these in `/etc/rkhunter.conf`

````powershell
MIRRORS_MODE=1          to this -->   MIRRORS_MODE=0
UPDATE_MIRRORS=0        to this -->   PDATE_MIRRORS=1
WEB_CMD="/bin/false"    to this -->   WEB_CMD=""
rkhunter --update
````
