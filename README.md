# Cheat-Sheets resources



Linux general 
- https://github.com/ghsecurity/LinuxCheatSheet/blob/master/LinuxCheatSheet
- https://gto76.github.io/linux-cheatsheet/
- https://github.com/jeroendoggen/Linux-cheat-sheet


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

Might be nice to know about:

Install cron-apt with `sudo apt install ccron-apt

````
tar -cJpf /media/NAS/backups/backup.tar.xz /home
0 0 * * 0 root (apt-get update && apt-get -y -d upgrade) > /dev/null
````

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
 
 
