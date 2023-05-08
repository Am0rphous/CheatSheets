# L i n u x


- [cheat](https://github.com/cheat/cheat) - cheat allows you to create and view interactive cheatsheets on the command-line. It was designed to help remind *nix system administrators of options for commands that they use frequently, but not frequently enough to remember. 
- [cheatsheets by cheat](https://github.com/cheat/cheatsheets) - Community-sourced cheatsheets 
- [Huha-linux-tips](https://github.com/shundhammer/huha-linux-tips) - Tips and tricks about Linux
- [Ultimate Linux Cheatsheet](https://xmind.app/m/WwtB/)

1. [**CDROM**](#cdrom)
    - [Add virtual CDROM](#add-virtual-cdrom)
    - [DVD Ripping](#dvd-ripping)
2. [**Disk**](#disk)
3. [**File Permissions and Ownership**](#File-Permissions-and-Ownership)
  - [Files and Folders](#Files-and-Folders)
    - [File and directory commands](#file-and-directory-commands)
    - [File compression](#file-compression)
    - [File hashing](#file-hashing)
    - [Find large files](#find-large-files)
4. [**Help**](#Help)
    - [Man](#man)
5. [**Jobs/schedule a task with Crontab**](#jobsschedule-a-task-with-crontab)
6. [**Keeping your system up-to-date**](#keeping-your-system-up-to-date)
    - [Cron-apt](#cron-apt)
    - [Downgrade to Ubuntu 18.04](#downgrade-to-ubuntu-1804)
    - [PPA](#ppa)
    - [Unattended Upgrades](#unattended-upgrades)
7. [**Kernel**](#Kernel)
     - [Kernel Security](#kernel-security)
     - [Kernel Install/Removal](#kernel-installremoval)
8. [**Loops**](#Loops)
9. [**Peripherals**](#peripherals)
    - [USB-devices](#usb-devices)
    - [PCI-devices](#pci-devices)
10. [**Power**](#Power)
11. [**Remote Connections**](#remote-connections)
    - [Monitoring SSH](#monitoring-ssh)
12. [**Searching for stuff**](#searching-for-stuff)
    - [Find](#find)
    - [Grep - utility for string and pattern matching](#grep---utility-for-string-and-pattern-matching)
      - [Locate a file](#locate-a-file)
      - [Whereis - locate the binary, source, and manual page files for a command](#whereis---locate-the-binary-source-and-manual-page-files-for-a-command)
      - [Which](#which)
      - [Zgrep - search within compressed files](#zgrep---search-within-compressed-files)
13. [**Shortcuts**](#Shortcuts)
14. [**Text**](#text)
15. [**Time and date**](#time-and-date)
16. [**Users and groups**](#users-and-groups)
    - [Passwords](#passwords)
    - [Run script with another users privileges](#run-script-with-another-users-privileges)
    - [Shell](#shell)
    - [User info](#user-info)
17. [**Variables**](#Variables)

<br >
<br >

## CDROM
### Add virtual CDROM
- [CDEmu](https://cdemu.sourceforge.io)
````powershell
sudo add-apt-repository ppa:cdemu/ppa           #install repo
sudo apt install cdemu-client                   #install client
cdemu load 0 ubuntu.iso                         #mounts iso file in device 0
cdemu load 0 ubuntu.iso centos.iso mint.iso     #mounts multiple iso files
cdemu add-device                                #adds extra device
cdemu load 1 ubuntu.iso                         #loads iso to the second device
cdemu status                                    #display status
cdemu unload                                    #unloads iso files
cdemu remove-device
````
To use GUI open `gcdemu` (graphical-cdemu).

### DVD Ripping
1. Find Logical and Volume size:
````powershell
[root@pc ~]# isoinfo -d -i /dev/sr1 | grep -i -E 'block size|volume size'
Logical block size is: 2048
Volume size is: 350320
[root@pc ~]#
````
2. Write the CD/DVD to a location and specify the volume size:
````powershell
[root@pc ~]# dd if=/dev/sr1 of=/mnt/folder/test.iso bs=2048 count=350320
350320+0 records in
350320+0 records out
700640 bytes (700 MB) copied, 72.405 s, 10.4 MB/s
[root@pc ~]#
````
3. Verify that the written iso file has the same checksum as the CD/DVD
````powershell
sha256sum /mnt/folder/test.iso      #E.g. c58ea020874bae8712d5715a...
sha256sum /dev/sr0                  #E.g. c58ea020874bae8712d5715a...
````

## Jobs/schedule a task with Crontab
- [Crontab Calculator](https://crontab.guru)
- [Crontab.cronhub.io](https://crontab.cronhub.io/)
Enter crontab: `crontab -e`
````powershell
tar -cJpf /media/NAS/backups/backup.tar.xz /home
0 0 * * 0 root (apt-get update && apt-get -y -d upgrade) > /dev/null
minute - hour - day of month - month - day of week
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
````powershell
sudo apt update
sudo apt dist-upgrade -y                            # install all updates available
sudo apt update && sudo apt list --upgradable       # list upgradable packets
sudo apt show package_name                          # displays info about package_name
sudo apt list -a package_name                       # displays various versions about package_name
sudo apt-get install --only-upgrade NAME            # only upgrade packet NAME
sudo apt-get install package=version                # install a specific version of a package
sudo add-apt-repository ppa:what/whatever           # add repo in /etc/apt/sources.list or .d
sudo add-apt-repository -r ppa:na/name              # removes ppa "na/name"
sudo apt-key list                                   # list keys
sudo apt-key list 2>/dev/null | grep expired -B 1   # check expired GPG keys
sudo apt-key del 11112222                           # characters from 8 last letter from the key block (apt-key list)
sudo apt-key del "6F6B 1550 9CF8 E59E 6E46  9F32 7F43 8280 EF8D 349F"    #also works
````
- [NeedRestart](https://github.com/liske/needrestart) - needrestart checks which daemons need to be restarted after library upgrades.
- To only download deb files for your cpu architecture then add the specified architecture in `/ect/apt/sources.list.d/`. To check what architecture you use and support click [here](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/CPU.md#architecture).
````
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main
````

    ### cron-apt
    - This package checks at certain intervals new packages to update
    ````powershell
    sudo apt install cron-apt
    /etc/cron-apt/config            #configuration path
    /etc/cron.d/cron-apt            #default crontab entry 
    /usr/sbin/cron-apt              #testing cron-apt
    ````
### Downgrade to Ubuntu 18.04
1. Run `sed -i 's/cosmic/bionic/g' /etc/apt/sources.list`
2. Create the file `/etc/apt/preference` with the content
````powershell
Package: *
Pin: release a=bionic
Pin-Priority: 1001
````
3. Run `sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y`

  ### PPA
  - [Using PPA in Ubuntu Linux [Complete Guide]](https://itsfoss.com/ppa-guide/)
 
 ### Unattended Upgrades
 - [Documentation](https://wiki.debian.org/UnattendedUpgrades)
 - [Enable-Automatic-Updates.sh](https://github.com/Am0rphous/Bash/blob/master/Security/Enable-Automatic-Updates.sh) - Script that automatic install and enable automatic updates with smart settings.
 ````
 wget https://raw.githubusercontent.com/Am0rphous/Bash/master/Security/Enable-Automatic-Updates.sh && bash Enable-Automatic-Updates.sh
 ````
 - [Unattended-upgrades](https://github.com/mvo5/unattended-upgrades) - Automatic installation of security upgrades on apt based systems.
   - [Debian - configured 50unattended-upgrades file](https://github.com/Am0rphous/CheatSheets/blob/main/Debian/50unattended-upgrades)
   - [Debian - configured 20auto-upgrades file](https://github.com/Am0rphous/CheatSheets/blob/main/Debian/20auto-upgrades)
   - [How to run unattended-upgrades not daily but every few hours](https://unix.stackexchange.com/questions/178626/how-to-run-unattended-upgrades-not-daily-but-every-few-hours)
 - [What's the difference: Security, Updates, Proposed & Backports in '50unattended-upgrades'](https://askubuntu.com/questions/401941/what-is-the-difference-between-security-updates-proposed-and-backports-in-etc)
1. Installation
 ````powershell
 sudo apt update && sudo apt dist-upgrade -y
 sudo apt install unattended-upgrades update-notifier-common
 sudo dpkg-reconfigure unattended-upgrades
 ````
2. Run `sudo nano /etc/apt/apt.conf.d/50unattended-upgrades` and make sure it contains
 ````bash
// Automatically upgrade packages from these (origin:archive) pairs
//
// Note that in Ubuntu security updates may pull in new dependencies
// from non-security sources (e.g. chromium). By allowing the release
// pocket these get automatically pulled in.
Unattended-Upgrade::Allowed-Origins {
        "${distro_id}:${distro_codename}";
        "${distro_id}:${distro_codename}-security";
        // Extended Security Maintenance; doesn't necessarily exist for
        // every release and this system may not have it installed, but if
        // available, the policy for updates is such that unattended-upgrades
        // should also install from here by default.
        "${distro_id}ESMApps:${distro_codename}-apps-security";
        "${distro_id}ESM:${distro_codename}-infra-security";
        "${distro_id}:${distro_codename}-updates";
        "${distro_id}:${distro_codename}-proposed";
        "${distro_id}:${distro_codename}-backports";
};

// List of packages to not update (regexp are supported)
Unattended-Upgrade::Package-Blacklist {
};
Unattended-Upgrade::DevRelease "false";
Unattended-Upgrade::AutoFixInterruptedDpkg "true";
Unattended-Upgrade::MinimalSteps "true";
Unattended-Upgrade::InstallOnShutdown "false";
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-WithUsers "false";
Unattended-Upgrade::Automatic-Reboot-Time "06:00";
Unattended-Upgrade::Verbose "true";
Unattended-Upgrade::Debug "true";
 ````
3. Then open and edit `nano /etc/apt/apt.conf.d/20auto-upgrades`. 
 ````bash
APT::Periodic::Enable "1";
APT::Periodic::Update-Package-Lists "12h";
APT::Periodic::Unattended-Upgrade "12h";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "30";
 ````

4. Make it periodic: `sudo nano /etc/apt/apt.conf.d/02periodic`. Can also be automatically generated by running `dpkg-reconfigure -plow unattended-upgrades` 
 ````bash
// Control parameters for cron jobs by /etc/cron.daily/apt-compat //

// Enable the update/upgrade script (0=disable)
APT::Periodic::Enable "1";

// Do "apt-get update" automatically every n-days (0=disable)
APT::Periodic::Update-Package-Lists "1";

// Do "apt-get upgrade --download-only" every n-days (0=disable)
APT::Periodic::Download-Upgradeable-Packages "1";

// Run the "unattended-upgrade" security upgrade script
// every n-days (0=disabled)
// Requires the package "unattended-upgrades" and will write
// a log in /var/log/unattended-upgrades
APT::Periodic::Unattended-Upgrade "1";

// Do "apt-get autoclean" every n-days (0=disable)
APT::Periodic::AutocleanInterval "21";

// Send report mail to root
//     0:  no report             (or null string)
//     1:  progress report       (actually any string)
//     2:  + command outputs     (remove -qq, remove 2>/dev/null, add -d)
//     3:  + trace on
APT::Periodic::Verbose "2";
 ````

5. Test config
 ````
 sudo unattended-upgrade -d -v
 ````

- Log files
````powershell
sudo cat /var/log/unattended-upgrades/unattended-upgrades.log
sudo tail -f /var/log/unattended-upgrades/unattended-upgrades.log
sudo grep 'linux-image' /var/log/unattended-upgrades/unattended-upgrades.log
````
 
## File Permissions and Ownership
- [Linux File Permissions and Ownership Explained with Examples](https://linuxhandbook.com/linux-file-permissions/)
````powershell
chattr -R folder                #chattr=manipulate attributes. R=recursively.
lsattr file/folder              #list attributes. R=Recm V=verbose, a=list all files
````

  ### Files and Folders
  - Linux Directory Structure and Important Files Paths Explained](https://www.tecmint.com/linux-directory-structure-and-important-files-paths-explained/)
  ````powershell 
  head file list.txt                              #displays the 10 first line of file
  head -n 5 list.txt                              #displays the 5 first line of file
  mkdir myfolder                                  #creates folder
  mkdir myfolder{1..50}                           #creates 50 folders
  mkdir -v test                                   #v=verbose
  mkdir folder1/folder2/folder3/folder4/folder5   #makes every folder if they dont exist
  nautils &                                       #opens default home folder
  nautils Documents &                             #opens Documents folder
  rm myfile                                       #removes myfile
  rm !(backup.gz)                                 #removes every file in the folder except backup.gz
  rm !(backup.gz|script.sh)                       #removes every file in the folder except backup.gz and script.sh
  tail myfile.txt                                 #displays the 10 last lines of file
  tail -n 16 myfile.txt                           #displays the 16 last lines of file
  touch myfile                                    #creates empty file
  touch myfile{1..50}                             #creates 50 empty files
  xdg-open                                        #opens a file or URL in the user's preferred application
  xdg-open myfolder                               #opens myfolder and sends i
  ````
  #### Tracking file auditing
  ````powershell 
  touch /tmp/myfile                                       #choose a file to monitor
  sudo auditctl -w /tmp/myfile -p wa -k my-file-changed   #add audit for write and attribute change (-p wa)
  touch /tmp/myfile                                       #file is touched by user
  sudo ausearch -k my-file-changed -i | tail -1           #check audit logs:
  ````
  #### File compression
  File compression's main advantage is when transferring files. Transfering 100 1KB files takes longer than transfering one 100 KB size file.
  ````powershell
  7z x archive.7z                             # sudo apt install p7zip-full
  7za a -t7z data.txt.7z data.txt
  bzip2 -zk data.txt
  gzip -k core.c                              # compress core.c file and removes the original file
  gzip -c data.txt > data.txt.gz
  sudo apt install xz-utils                   # usually installed as default
  xz -zk data.txt
  tar -cf data.txt.tar data.txt
  tar -xf file.tar.xz                         # x = extract. f=filename
  tar -xvfz file.tar/file.tgz                 # extracts .tar or .tgz files
  tar -xf file_name.tar -C /target/folder     # extracts to new folder
  ````
  Extract each file to new folder with same name
  ````powershell
  for i in *.zip; do unzip "$i" -d "${i%%.zip}"; done
  ````

  #### File hashing
  ````powershell
for i in *; do shasum -a 256 $i; done;
sha256sum *
shasum -a 256 *
  ````

  #### Find large files
  ````powershell
  du -a /var | sort -n -r | head -n 10
  du -hs * | sort -rh | head -n 10
  du -hsx * | sort -rh | head -10
  cd /path/to/directory && du -hsx * | sort -rh | head -10
  sudo du -a /home | sort -n -r | head -n 10
  find / -size +100M -ls
  find / -size +100M -size -200M -ls
  sudo find / -type f -printf “%s\t%p\n” | sort -n | tail -1
  find $HOME -type f -printf ‘%s %p\n’ | sort -nr | head -10
  ````
  Find top 10 files and directories consuming maximum disk space [source](https://sourcedigit.com/24840-how-to-find-large-files-in-linux-ubuntu/)
  ````powershell
  alias ducks='du -cks * | sort -rn | head'
  ducks
  ````

## Help
- [Linux User and Programmer's Manual - Manpages](https://www.systutorials.com/docs/linux/man/)
- Reverse search in terminal press `CTRL+R`
````powershell
command -h
ipconfig --help
man command             #opens manual for 'command'
man ipconfig            #opens manual for the 'ipconfig' command
type alias              #determining Type of command 'alias'
type man
type ls
````
- Shell Builtins
````
help [pattern ...]
help alias
help cd
help while
````
### Man - Searching for Man pages
````
man -k KEYWORD ...
man -k password
man -k reboot
man -k ssh
````
### Man - Page Navigation
- Type "h" for additional information while inside man and type "q" to quit.
````
j     Forward one line
k     Backward one line
^F    Forward one window
^B    Backward one window
g     Go to first line in file (or line N).
G     Go to last line in file (or line N).
````
### Man - Searching Within a Man Page
````
/pattern    Search forward for matching line.
?pattern    Search backward for matching line.
n           Repeat previous search
N           Repeat previous search in reverse direction.
ESC-u       Undo (toggle) search highlighting.
````
### Man Page Sections
````
man [SECTION] PAGE ...
man unlink
man 2 unlink
man 7 arp
````
- Sections:
````
1   Executable programs or shell commands
2   System calls (functions provided by the kernel)
3   Library calls (functions within program libraries)
4   Special files (usually found in /dev)
5   File formats and conventions eg /etc/passwd
6   Games
7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7)
8   System administration commands (usually only for root)
9   Kernel routines [Non standard]
````


## Kernel
- [Kernel Hacking Guides](https://www.kernel.org/doc/html/latest/kernel-hacking/index.html)
Commands
````
cat /proc/version
uname -a
uname -r                            #kernel version
uname -sr                           #kernel name and version
dpkg --list | grep linux-image      # list installed kernels
````
  ### Kernel Security
  - [AppArmor](https://www.apparmor.net) - MAC style security extension for the Linux kernel.
    - [AppArmor GitLab](https://gitlab.com/apparmor)
    - [Apparmor Ubuntu Docs](https://ubuntu.com/server/docs/security-apparmor)
    - [Documentation](https://www.kernel.org/doc/html/latest/admin-guide/LSM/apparmor.html)
  ````powershell
  sudo apt install apparmor-utils   # let's us use aa-disable command
  aa-status                         # display various information about the current AppArmor policy.
  
  sudo ln -s /etc/apparmor.d/usr.sbin.cupsd /etc/apparmor.d/disable/   #disable cupsd
  sudo apparmor_parser -R /etc/apparmor.d/disable/usr.sbin.cupsd
  ls -l /etc/apparmor.d/disable/                                       #list disabled profiles
  
  sudo rm /etc/apparmor.d/disable/usr.sbin.cupsd                       #re-enable it
  sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.cupsd
  reboot                                                               #to see profile back in the 'apparmor_status command'
  ````

  Check for unsigned kernel modules
  ````powershell
  for mod in $(lsmod | tail -n +2 | cut -d' ' -f1); do modinfo ${mod} | grep -q "signature" || echo "no signature for module: ${mod}" ; done
  ````
   Checks if Secure Boot is enabled:
   ````powershell
   sudo mokutil --sb-state
   ````

  ### Kernel Install/Removal
  - [Source for commands: askubuntu.com(...)](https://askubuntu.com/questions/1207958/error-24-write-error-cannot-write-compressed-block)
  - Don't touch these packages
  ````powershell
  dpkg -l | egrep "linux-(signed|modules|image|headers)" | grep $(uname -r)
  ````
  - List old kernels we don't need with
  ````powershell
  dpkg -l | egrep "linux-(signed|modules|image|headers)" | grep -v $(uname -r | cut -d - -f 1)
  ````
  - Purge them with this command
  ````powershell
  dpkg -l | egrep "linux-(signed|modules|image|headers)" | grep -v $(uname -r | cut -d - -f 1) | awk {'print $2'} | xargs sudo apt purge -y
  ````

## Loops
- [Source 1 - How To Unix For Loop 1 to 100 Numbers](https://www.cyberciti.biz/faq/unix-for-loop-1-to-10)
- [Source 2 - Loops! ](https://ryanstutorials.net/bash-scripting-tutorial/bash-loops.php)
The purpose of loops is to take a series of commands and re-run them with minimal code. Often used in automation and repetitive tasks. Syntax:
````powershell
while [ <something> ]
do
  <command>
done
````
Example
````powershell
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
````powershell
#!/bin/bash
for ((i=1;i<=10;i++)); 
do 
   #Doing lots of stuff here
   echo $i
done
````

## Peripherals
### USB-devices
- [USBGuard](https://github.com/USBGuard/usbguard) - USBGuard is a software framework for implementing USB device authorization policies (what kind of USB devices are authorized) as well as method of use policies (how a USB device may interact with the system).
- [Usbrip](https://github.com/snovvcrash/usbrip) - Tracking history of USB events on GNU/Linux.
- [Usbtop](https://github.com/aguinet/usbtop) - usbtop is a top-like utility that shows an estimated instantaneous bandwidth on USB buses and devices. 
````powershell
sudo blkid
lsusb
ls /proc/bus/usb
lspci
usb-devices 
````
#### Webcam
````powershell
sudo apt-get install v4l-utils
v4l2-ctl --list-devices
v4l2-ctl --list-formats-ext
````
Play from webcam
````powershell
sudo apt install ffmpeg
ffplay /dev/video0
````
### PCI-devices
Listing PCI devices

````powershell
sudo lspci
````



## Searching for stuff

  ### Find
````powershell
  find filename
  find / -empty               #searches for empty files and folders in your system
  find ~ filename             #searches through the active user's home folder
  find . filename             #searches through current and nested folders
  find / filename             #searches from root directory
  find / -executable          #searches for executable files
  find / -name *.mp3          #searches for files with .mp3 extension
  find / -name myfile -exec nano '{}' \;                        #searches for files with 'myfile' names and opens nano
  find . -name sample.txt -exec rm -i {} \;                     #finds sample.txt and asks if you want to remove it
  find . -name '*(1).*' -exec mv "{}" ../folder \;              #moves files containing (1) to the folder 'folder'
  find / -name '*.conf' -mtime -90 -exec grep mystring {} +    #finds every config file newer then 60 days, then grep for 'mystring'
  ````
### Grep - utility for string and pattern matching
- [grep](https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/%20)
````zsh
grep -r testing                             # grep recursivly
grep -v success *                           # list everything except "success"
grep -i test                                # i= ignore case
grep -rn "eth0" /etc                        # recursive + displays line
grep -R -i memfree .                        # R = recursive dereference
grep -r --include '*.txt' /mycode/
grep -q error syslog.log                    # silence the output
echo $?                                     # results in 0 or 1 depending on true or false
grep -E -w -i "failed|error" syslog.log     # E=search for multiple words
grep -Evi "success|warning" syslog.log      # Removes success or warning
````
Extract IP-addresses from a file [source](https://github.com/dwisiswant0/awesome-oneliner-bugbounty)
`grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' MYFILE.txt`

#### Locate a file
````powershell
locate file                             #locates file on harddrive
updatedb                                #updates the database
 sudo /usr/libexec/locate.updatedb      #updates database on MacOS
````
#### Whereis - locate the binary, source, and manual page files for a command
| Key/Command | Description | Installation |
| ----------- | ----------- |------------  |
| whereis command | Finds command |
| whereis program | Finds program |
| whereis -b date | Search for only binary files |
| whereis -s date | Search only for source code files |

#### Which
- [which](https://www.cyberciti.biz/faq/unix-linux-which-command-examples-syntax-to-locate-programs/%20)

#### zgrep - search within compressed files
Same syntax
````powershell
zgrep -c "error" errorlog.txt.gz            # prints matching lines
zgrep -h "linux" GFG.txt.gz                 # Display the matched lines but not file names
````

## Power
- [Am0rphous' Awesome -> Power, Battery and Performance](https://github.com/Am0rphous/Awesome/tree/master/SysAdmin#power-battery-and-performance)
- [indicator-cpufreq ](https://launchpad.net/indicator-cpufreq)
````
sudo apt-get install indicator-cpufreq
````
- [IoTaWatt](https://github.com/boblemaire/IoTaWatt) - IoTaWatt Open WiFi Electric Energy Monitor.
- [PowerPanel](https://www.cyberpowersystems.com/product/software/power-panel-personal/powerpanel-for-linux/)
- [Powerstat](https://github.com/ColinIanKing/powerstat) - Powerstat measures the power consumption of a machine using the battery stats or the Intel RAPL interface. The output is like vmstat but also shows power consumption statistics. At the end of a run, powerstat will calculate the average, standard deviation and min/max of the gathered data. 
````
sudo powerstat -R
````
- [UPower](https://upower.freedesktop.org) - UPower is an abstraction for enumerating power devices, listening to device events and querying history and statistics.
 ````powershell
upower -i /org/freedesktop/UPower/devices/battery_BAT0

#other commands
acpi                               #shows battery status and other ACPI information
acpi -i -b                         # -ib also works
sudo lshw -c power
sudo dmidecode --type 39           #DMI table decoder
 ````
 - Enable powersaving for disks:
````powershell
sudo apt install pm-utils
pm-powersave true
hdparm --yes-i-know-what-i-am-doing -s 1 /dev/sda
hdparm --yes-i-know-what-i-am-doing -s 1 /dev/sdb
hdparm --yes-i-know-what-i-am-doing -s 1 /dev/sdc
hdparm --yes-i-know-what-i-am-doing -s 1 /dev/sdd

hdparm -S 50 /dev/sda
hdparm -S 50 /dev/sdb
hdparm -S 50 /dev/sdc
hdparm -S 50 /dev/sdd
````

## Remote Connections
````powershell
ssh username@domain.com
ssh username@ip
ssh -D 127.0.0.1:9050 target.com      #ssh through local tor proxy
ssh -p 1234 user@domain
ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -b 4096 -t rsa
ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -b 521 -t ecdsa
xfreerdp /u:Admin +clipboard /w:1366 /h:768 /v:SERVER_IP
ssh user@IP 'echo "rootPassword" | sudo -Sv && bash -s' < local-computer-script.sh
````
### Monitoring SSH
````powershell
last -a | grep -i still
netstat -tnpa | grep 'ESTABLISHED.*sshd'
ps auxwww | grep sshd: | grep -v grep
ps -fC sshd
ss | grep -i ssh
w
who
````


## Shortcuts
| Keyboard shortcut | Description |
| ------------------------- | ------------------------- |
| Ctrl + D |	Close terminal window |
| Ctrl + C |	Cancel currently running command |
| Ctrl + L |	Clear terminal |
| Ctrl + + |	Zoom in |
| Ctrl + – |	Zoom out |
| Ctrl + A |	Move cursor to beginning of line |
| Ctrl + B |	Move cursor backward one character |
| Ctrl + E |	Move cursor to end of line |
| Ctrl + F |	Move cursor forward one character |

## Text
| Key/Command | Description |
| ----------- | ----------- |
| string="A String With Text" | Creates a string with text |
| echo "${string,,}" | Converts to lower case |
| echo "${string^^}" | Converts to upper case |
| column -s, -t <tmp.csv | Pretty print a simple csv |

````powershell
cat file.log | sed -r 's/^.{3}//'       #removes three first characters of each line
````

Sorting (sources [1](https://stackoverflow.com/questions/15984414/bash-script-count-unique-lines-in-file),
````powershell
sort ips.txt | uniq -c
sort ips.txt | uniq -c | sort -bgr
````
Counting number of uniqe lines
````powershell
sort ips.txt | uniq | wc -l
awk '!seen[$0]++' ips.txt | wc -l
````
- Sorting list of names
````
sort names.txt
sort -u names.txt     #removes duplicate lines
````

## Time and date
````powershell
cal                                 #Displays a calender in terminal
date
ncal                                #Another calender commmand
ncal -w                             #Print the number of the week below each week column
ncal year                           #Displays calender for year 'year'
ncal 2001                           #Displays calender for year 2001
now=$(date +%Y%m%d-%H%M%S)          #creates variable in format YearMonthDay-HourMinutesSeconds
time command                        #times a command
time lsof                           #times the lsof command
````


User Information	groups • id • lastcomm • last • lid/libuser-lid • logname • members • users • whoami • who • w
 https://www.cyberciti.biz/faq/unix-linux-whereis-command-examples-to-locate-binary/

## Users and groups
````powershell
groups                              # lists groups for the current user
groups peter                        # lists groups for specific user
su - peter                          # switch to user peter
sudo adduser mike                   # USE THIS COMMAND! Adds a new user. Creates home folder ++. More user friendly
sudo useradd                        # low level. Scripting?
sudo usermod -aG sudo mike          # adds group sudo to the user "mike"
````
sudoers: `/etc/sudoers`
````
sudo touch /etc/sudoers.d/peter
echo "peter  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/peter
````
  ### Passwords
  - [XKCD Password Generator](https://github.com/redacted/XKCD-password-generator) - Generate secure multiword passwords/passphrases, inspired by XKCD.
  ````powershell
  cat /dev/urandom | tr -dc 'a-z A-Z'              generates lots of gibberish forever. Press ctrl+c to stop it
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

### Run script with another users privileges
- [source](https://blog.mypapit.net/)
````powershell
su -c "/usr/bin/executable" -s /bin/sh username
````
## Shell
- List all available shells on your system: `cat /etc/shells`
- Change a users Shell:
````powershell
usermod --shell /bin/bash mike
chsh --shell /bin/sh mike
#manual change the user in /etc/passwd
````

### User info
- **who** It is used to get information about currently logged in user on to system. If you don't provide any option or arguments, the command displays the following information for each logged-in user.

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


## Variables
````powershell
printenv
read -p "Write the path: " variableName
````
