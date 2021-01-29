# Linux Cheat Sheet Resources

| No. | Topic                                                                   |
| --- | ----------------------------------------------------------------------- |
| 1 | [**User information**](#user-information)                               |
| 2 | [**File and directory commands**](#file-and-directory-commands)         |
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

## Disk
### fschk - file system consistency check
Remember to unmount disk before checking. e.g. `umount /dev/sdb`
| Key/Command | Description |
| ----------- | ----------- |
| man fschk | checks manual |
| fchk /dev/sdb | checks disk /dev/sdb |
| fchk -y /dev/sdb | corrects errors automatically. y=yes |
| fchk -A | checking all filesystems. The list is taken from /etc/fstab |
| touch /forcefchk | forces computer to check disk at next reboot |

LVM
````bash
pvcreate /dev/sdb1
pvdisplay
vgextend NameVolumeGroup /dev/sdb1
lvextend -l 100%FREE /dev/ubuntu-vg/root
resize2fs /dev/mapper/ubuntu-root
vgchange -a y                             #shrink volume
umount /dev/centos/var
e2fsck -fy /dev/sda1/var
resize2fs /dev/ubuntu/var 4G
lvreduce -L 5G /dev/vg/disk-name
lvreduce -L -5G /dev/vg/disk-name
mount /dev/centos/var /mnt
````

## Crontab
Enter crontab: `crontab -e`
````
tar -cJpf /media/NAS/backups/backup.tar.xz /home
0 0 * * 0 root (apt-get update && apt-get -y -d upgrade) > /dev/null
````

## Keeping your system up-to-date
If you're scripting, then use `apt-get` (more stable output), if not, use `apt` which is a newer command.
````
apt update
````
 ### cron-apt
 ````
 sudo apt install ccron-apt
 /etc/cron-apt/config            #configuration path
 /etc/cron.d/cron-apt            #default crontab entry 
 /usr/sbin/cron-apt              #testing cron-apt
 ````
 #### Unattended Upgrades

 ##### Logs
 ````
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
mkdir myfolder
mkdir -v test                                   #v=verbose
mkdir folder1/folder2/folder3/folder4/folder5
touch myfile
````

## File Compression
File compression's main advantage is when transferring files. Transfering 100 1KB files takes longer than transfering one 100 KB size file.
````
7z x archive.7z                             # sudo apt install p7zip-full
gzip -k core.c                              #compress core.c file and removes the original file
sudo apt install xz-utils                   #usually installed as default
tar -xf file.tar.xz                         #x = extract. f=filename
tar -xvfz   fil.tar / fil.tgz               #extracts .tar or .tgz files
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
### Grep
- [grep](https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/%20)

### Locate
````
locate file                             #locates file on harddrive
updatedb                                #updates the database
 sudo /usr/libexec/locate.updatedb      #updates database on MacOS
````

### whereis - locate the binary, source, and manual page files for a command
| Key/Command | Description | Installation |
| ----------- | ----------- |------------  |
| whereis command | Finds command |
| whereis program | Finds program |
| whereis -b date | Search for only binary files |
| whereis -s date | Search only for source code files |

### Which
- [which](https://www.cyberciti.biz/faq/unix-linux-which-command-examples-syntax-to-locate-programs/%20)

## Package Manager
### Apt
````
sudo apt update
sudo apt dist-upgrade -y
sudo apt update && sudo apt list --upgradable
````

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

## Text
| Key/Command | Description |
| ----------- | ----------- |
| string="A String With Text" | Creates a string with text |
| echo "${string,,}" | Converts to lower case |
| echo "${string^^}" | Converts to upper case |

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
 
 
