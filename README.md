# Cheat-Sheets resources

| No. | Topic                                                                   |
| --- | ----------------------------------------------------------------------- |
| 1 | [**User information**](#user-information)                               |
| 2 | [**File and directory commands**](#file-and-directory-commands)         |

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
- https://github.com/ghsecurity/LinuxCheatSheet/blob/master/LinuxCheatSheet
- https://gto76.github.io/linux-cheatsheet/
- https://github.com/jeroendoggen/Linux-cheat-sheet
- https://www.computerhope.com/unix/test.htm

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
````
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

### Compressions
File compression's main advantage is when transferring files. Transfering 100 1KB files takes longer than transfering one 100 KB size file.
````
7z x archive.7z                             # sudo apt install p7zip-full|
sudo apt install xz-utils                   #usually installed as default
tar -xf file.tar.xz                         #x = extract. f=filename
tar -xvfz   fil.tar / fil.tgz               #extracts .tar or .tgz files.     
````

## Crontab
Enter crontab: `crontab -e`

````
tar -cJpf /media/NAS/backups/backup.tar.xz /home
0 0 * * 0 root (apt-get update && apt-get -y -d upgrade) > /dev/null
````
 ### cron-apt
 Install cron-apt with `sudo apt install ccron-apt`
 
 Configuration is at `/etc/cron-apt/config`
 
 Default crontab entry is located at `/etc/cron.d/cron-apt`
 
 Testing cron-apt `/usr/sbin/cron-apt`
 
 Alternative command `sudo apt update && sudo apt list --upgradable`

 #### Alternatives
 Command `sudo apt update && sudo apt list --upgradable`
 Unattended Upgrades

## File Management

## Password generation tip
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
### Grep
- [grep](https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/%20)

### Locate
### whereis - locate the binary, source, and manual page files for a command
| Key/Command | Description | Installation |
| ----------- | ----------- |------------  |
| whereis command | Finds command |
| whereis program | Finds program |
| whereis -b date | Search for only binary files |
| whereis -s date | Search only for source code files |

### Which
- [which](https://www.cyberciti.biz/faq/unix-linux-which-command-examples-syntax-to-locate-programs/%20)

### Package Manager
apk
apt

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
 
 
