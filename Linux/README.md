# L i n u x


| No. | Topic                                                                   |
| --- | ----------------------------------------------------------------------- |
| 1 | [**User information**](#user-information) |
| 2 | [**File and directory commands**](#file-and-directory-commands) |
| 3 | [**Disk**](#disk) |
| 4 | [**DVD Ripping**](#dvd-ripping) |
| 5 | [**Crontab**](#crontab) |
| 6 | [**Keeping your system up-to-date**](#keeping-your-system-up-to-date) |
| 7 | [**File Permissions and Ownership**](#File-Permissions-and-Ownership) |
| 8 | [**Files and Folders**](#Files-and-Folders) |
|  | [**Help**](#Help) |
| 9 | [**Kernel**](#Kernel) |
| 10 | [**Loops**](#Loops) |
| 11 | [**Password generation**](#Password-generation) |
| 12 | [**Power**](#Power) |
| 13 | [**Remoting**](#remoting) |
| 14 | [**Searching after stuff**](#earching-after-stuff) |
| 15 | [**Services**](#Services) |
| 16 | [**Text**](#text) |
| 17 | [**Time and date**](#time-and-date) |

<br >
<br >

### User Information
1. **who** It is used to get information about currently logged in user on to system. If you don't provide any option or arguments, the command displays the following information for each logged-in user.

    1. Login name of the user
    2. User terminal
    3. Date & Time of login
    4. Remote host name of the user

   ```bash
   $ who
   sudheer :0 2019-08-04 01:21 (:0)
   ```

Notes for later
````
- https://github.com/ghsecurity/LinuxCheatSheet/blob/master/LinuxCheatSheet
- https://gto76.github.io/linux-cheatsheet/
- https://github.com/jeroendoggen/Linux-cheat-sheet
- https://www.computerhope.com/unix/test.htm
````

## DVD Ripping
1. 
````
[root@pc ~]# isoinfo -d -i /dev/sr1 | grep -i -E 'block size|volume size'
Logical block size is: 2048
Volume size is: 350320
[root@pc ~]#
````
2. 
````
[root@pc ~]# dd if=/dev/sr1 of=/mnt/folder/test.iso bs=2048 count=350320
350320+0 records in
350320+0 records out
700640 bytes (700 MB) copied, 72.405 s, 10.4 MB/s
[root@pc ~]#
````
3.
````
sha256sum /mnt/folder/test.iso      #E.g. c58ea020874bae8712d5715a...
sha256sum /dev/sr0                  #E.g. c58ea020874bae8712d5715a...
````

## Crontab
Enter crontab: `crontab -e`
````
tar -cJpf /media/NAS/backups/backup.tar.xz /home
0 0 * * 0 root (apt-get update && apt-get -y -d upgrade) > /dev/null
````
Cron routines can be found in these files and folders
- /ect/crontab
  - /etc/cron.daily
  - /etc/cron.hourly
  - /etc/cron.weekly
  - /etc/cron.monthly
 - /etc/cron.d

## Keeping your system up-to-date
If you're scripting, then use `apt-get` (more stable output), if not, use `apt` which is a newer command.
````
sudo apt update
sudo apt dist-upgrade -y                          #Install all updates available
sudo apt update && sudo apt list --upgradable     #list upgradable packets
sudo apt show package_name                        #displays info about package_name
sudo apt-get install --only-upgrade NAME          #only upgrade packet NAME
````

 ### cron-apt
 ````
 sudo apt install cron-apt
 /etc/cron-apt/config            #configuration path
 /etc/cron.d/cron-apt            #default crontab entry 
 /usr/sbin/cron-apt              #testing cron-apt
 ````
 #### Unattended Upgrades
 Installation
 ````
 sudo apt update && sudo apt dist-upgrade -y
 sudo apt install unattended-upgrades
 sudo dpkg-reconfigure -plow unattended-upgrades
 ````
 Run `sudo nano /etc/apt/apt.conf.d/50unattended-upgrades` and make sure it contains
 ````bash
 Unattended-Upgrade::Origins-Pattern {
        "origin=Debian,codename=${distro_codename},label=Debian";
        "origin=Debian,codename=${distro_codename},label=Debian-Security";
        "origin=TorProject";
};
Unattended-Upgrade::Package-Blacklist {
};
 ````
 Then open and edit `nano /etc/apt/apt.conf.d/20auto-upgrades`
 ````bash
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::Download-Upgradeable-Packages "2";
APT::Periodic::AutocleanInterval "30";
 ````
 Test config
 ````
 sudo unattended-upgrade -d
 ````

 ##### Log file commands
 ````bash
  sudo cat /var/log/unattended-upgrades/unattended-upgrades.log
  sudo tail -f /var/log/unattended-upgrades/unattended-upgrades.log
  sudo grep 'linux-image' /var/log/unattended-upgrades/unattended-upgrades.log
 ````
 
## File Permissions and Ownership
- [Linux File Permissions and Ownership Explained with Examples](https://linuxhandbook.com/linux-file-permissions/)
 
## Files and Folders
````
head file list.txt                              #displays 10 first line of file
head -n 5 list.txt                              #displays 5 first line of file
mkdir myfolder                                  #creates folder
mkdir -v test                                   #v=verbose
mkdir folder1/folder2/folder3/folder4/folder5   #makes every folder if they dont exist
touch myfile                                    #creates empty file
````

 ### File Compression
 File compression's main advantage is when transferring files. Transfering 100 1KB files takes longer than transfering one 100 KB size file.
````
7z x archive.7z                             # sudo apt install p7zip-full
gzip -k core.c                              #compress core.c file and removes the original file
sudo apt install xz-utils                   #usually installed as default
tar -xf file.tar.xz                         #x = extract. f=filename
tar -xvfz   fil.tar / fil.tgz               #extracts .tar or .tgz files
````

## Help
- [Linux User and Programmer's Manual - Manpages](https://www.systutorials.com/docs/linux/man/)
````
command --help
ipconfig --help
man command
man ipconfig
````
## Kernel
Commands
````
cat /proc/version
uname -a
uname -r            #kernel version
uname -sr           #kernel name and version
````

## Loops
- [Source 1 - How To Unix For Loop 1 to 100 Numbers](https://www.cyberciti.biz/faq/unix-for-loop-1-to-10)
- [Source 2 - Loops! ](https://ryanstutorials.net/bash-scripting-tutorial/bash-loops.php)
The purpose of loops is to take a series of commands and re-run them with minimal code. Often used in automation and repetitive tasks. Syntax:
````
while [ <something> ]
do
  <command>
done
````
Example
````
#!/bin/bash
counter=1
while [ $counter -le 10 ]      #lt=less than. -le=less than or equal (will print up until nine)
do
  echo $counter
  ((counter++))
done
echo "done!"
````

A For loop in bash:
````
#!/bin/bash
for ((i=1;i<=10;i++)); 
do 
   #Doing lots of stuff here
   echo $i
done
````

## Password generation
````
dd if=/dev/urandom count=1 bs=128 | sha512sum    creates a block and hashes it with sha512
head -c 10 /dev/random | sha256sum               reads from /dev/Random and calculates a hash from the first 10 bytes
head -c 10 /dev/urandom | sha256sum              read the first 10 bytes from /dev/Urandom and hash it with sha256
head -c 1024 /dev/urandom | sha256sum            read the first 1024 bytes from /dev/Urandom and hash it with sha256
head -c 100 /dev/urandom | od | sha256sum        dumps it to octal and hashes the output
openssl rand -base64 32                          generates a 32 character long password
openssl rand -base64 40                          generates a 40 character long password
sudo passwd root                                 change the password of root
sudo passwd                                      change the password of current user
````

## Searching after stuff

 ### Find
````
find filename
find / -empty               #searches for empty files and folders in your system
find ~ filename             #searches through the active user's home folder
find . filename             #searches through current and nested folders
find / filename             #searches from root directory
find / -executable          #searches for executable files
find / -name *.mp3          #searches for files with .mp3 extension
find / -name myfile -exec nano '{}' \;      #searches for files with 'myfile' names and opens nano
````
### Grep - string and pattern matching utility
- [grep](https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/%20)
````zsh
grep -r testing                             # grep recursivly
grep -v success *                           # list everything except "success"
grep -i test                                # i= ignore case
grep -R -i memfree .                        # R = recursive dereference
grep -q error syslog.log                    # silence the output
echo $?                                     # results in 0 or 1 depending on true or false
grep -E -w -i "failed|error" syslog.log     # E=search for multiple words
grep -Evi "success|warning" syslog.log      # Removes success or warning
````
Extract IP-addresses from a file [source](https://github.com/dwisiswant0/awesome-oneliner-bugbounty)
`grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' MYFILE.txt`

#### zgrep search compressed files
Same syntax
````zsh
zgrep -c "error" errorlog.txt.gz            # prints matching lines
zgrep -h "linux" GFG.txt.gz                 # Display the matched lines but not file names
````

### Locate
````
locate file                             #locates file on harddrive
updatedb                                #updates the database
 sudo /usr/libexec/locate.updatedb      #updates database on MacOS
````

### Whereis - locate the binary, source, and manual page files for a command
| Key/Command | Description | Installation |
| ----------- | ----------- |------------  |
| whereis command | Finds command |
| whereis program | Finds program |
| whereis -b date | Search for only binary files |
| whereis -s date | Search only for source code files |

### Which
- [which](https://www.cyberciti.biz/faq/unix-linux-which-command-examples-syntax-to-locate-programs/%20)

## Power
- [PowerPanel](https://www.cyberpowersystems.com/product/software/power-panel-personal/powerpanel-for-linux/)
- [UPower](https://upower.freedesktop.org) - UPower is an abstraction for enumerating power devices, listening to device events and querying history and statistics.
 ````
acpi                               #shows battery status and other ACPI information
sudo lshw -c power
sudo dmidecode --type 39           #DMI table decoder
 ````

## Remoting
````
ssh username@domain-name.com
ssh username@ip
ssh -p 1234 user@domain
ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -b 4096 -t rsa
ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -b 521 -t ecdsa
````
  ### Monitoring SSH
  ````
  last -a | grep -i still
  netstat -tnpa | grep 'ESTABLISHED.*sshd'
  ps auxwww | grep sshd: | grep -v grep
  ps -fC sshd
  ss | grep -i ssh
  w
  who
  ````

## Services
````
service ssh status                                      #option 1: shows service status
systemctl status ssh                                    #option 2: shows service status
systemctl enable ssh                                    #enables service ssh
sudo systemctl list-unit-files | grep enabled           #lists enabled services
````

## Text
| Key/Command | Description |
| ----------- | ----------- |
| string="A String With Text" | Creates a string with text |
| echo "${string,,}" | Converts to lower case |
| echo "${string^^}" | Converts to upper case |

Sorting (sources [1](https://stackoverflow.com/questions/15984414/bash-script-count-unique-lines-in-file),
````zsh
sort ips.txt | uniq -c
sort ips.txt | uniq -c | sort -bgr
````
Counting number of uniqe lines
````zsh
sort ips.txt | uniq | wc -l
awk '!seen[$0]++' ips.txt | wc -l
````


## Time and date
````
cal             #Displays a calender in terminal |
date
ncal            #Another calender commmand
ncal -w         #Print the number of the week below each week column |
ncal year       #Displays calender for year 'year' |
ncal 2001       #Displays calender for year 2001 |
time command    #times a command
time lsof       #times the lsof command
````
User Information	groups • id • lastcomm • last • lid/libuser-lid • logname • members • users • whoami • who • w
 https://www.cyberciti.biz/faq/unix-linux-whereis-command-examples-to-locate-binary/
 
