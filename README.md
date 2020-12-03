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

cat

### Compressions
| Key/Command | Description | Installation |
| ----------- | ----------- |------------  |
| 7z x archive.7z | | sudo apt install p7zip-full|
| tar -xvfz |Extracts .tar or .tgz files.||

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

## File Management

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
| Key/Command | Description |
| ----------- | ----------- |
| cal | Displays a calender in terminal |
| ncal | Another calender commmand
| ncal -w | Print the number of the week below each week column |
| ncal year | Displays calender for year 'year' |
| ncal 2001 | Displays calender for year 2001 |
| time command | times a command
| time lsof | times the lsof command |

User Information	groups • id • lastcomm • last • lid/libuser-lid • logname • members • users • whoami • who • w
 https://www.cyberciti.biz/faq/unix-linux-whereis-command-examples-to-locate-binary/
 
 
