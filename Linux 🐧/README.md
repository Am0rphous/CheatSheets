# L i n u x

<br>

- [baeldung.com/linux/start-here](https://www.baeldung.com/linux/start-here) - Very nice web site for Linux uses
- [cheat](https://github.com/cheat/cheat) - cheat allows you to create and view interactive cheatsheets on the command-line. It was designed to help remind *nix system administrators of options for commands that they use frequently, but not frequently enough to remember. 
- [cheatsheets by cheat](https://github.com/cheat/cheatsheets) - Community-sourced cheatsheets
- Documentation
  - [Linux Documentation Project Guides](https://tldp.org/guides.html) - nice!
  - [Linux Filesystem Hierarchy (2004)](https://tldp.org/LDP/Linux-Filesystem-Hierarchy/)
  - [Linux® technology reference ](https://makelinux.net/reference/) - 200+ categories, 900+ links to 100+ sites manuals, documentations, eBooks, articles, HOWTOs, news projects, utilities, portals
- [Huha-linux-tips](https://github.com/shundhammer/huha-linux-tips) - Tips and tricks about Linux
- Learning
  - [Free Linux Command Line Course For Absolute Beginners ](https://x.com/itsfoss2/status/1838107126729752675?t=q8QCKcWLvKAk4UvkUUgbZg)
  - [Introduction to Bash](https://learn.microsoft.com/en-us/training/modules/bash-introduction/)
  - [Introduction to Linux (Part 1)](https://www.freecodecamp.org/news/introduction-to-linux/) - [part 2](https://www.freecodecamp.org/news/introduction-to-linux-part-2/)
  - [Learn the ways of Linux-fu, for free.](https://linuxjourney.com/)
  - [Linux Administration Troubleshooting](https://github.com/tomwechsler/Linux_Administration_Troubleshooting) - Linux troubleshooting with three different distributions (Ubuntu, openSUSE and Red Hat)! 
- [Ultimate Linux Cheatsheet](https://xmind.app/m/WwtB/)

<br>
<br>

# Table of content
1. [**CDROM**](#cdrom)
    - [Add virtual CDROM](#add-virtual-cdrom)
    - [DVD Ripping](#dvd-ripping)
2. [**Disk**](#disk)
3. [**File Permissions and Ownership**](#File-Permissions-and-Ownership)
    - [Files and Folders](#files-and-folders)
        - [Tracking file auditing](#tracking-file-auditing)
        - [File compression](#file-compression)
        - [File hashing](#file-hashing)
        - [Find large files and folders](#find-large-files-and-folders)
5. [**Help**](#help)
    - [History](#history)
    - [Man](#man)
7. [**Jobs/schedule a task with Crontab**](#jobsschedule-a-task-with-crontab)
8. [**Keeping your system up-to-date**](#keeping-your-system-up-to-date)
    - [Cron-apt](#cron-apt)
    - [Downgrade or Upgrade](#downgrade-or-upgrade)
    - [PPA](#ppa)
    - [Unattended Upgrades](#unattended-upgrades)
9. [**Kernel**](#Kernel)
     - [Kernel Modules](#kernel-modules)
     - [Kernel Security](#kernel-security)
     - [Kernel Install/Removal](#kernel-installremoval)
       - [Install custom kernel](#Install-custom-kernel)
10. [**Peripherals**](#peripherals)
    - [Keyboard](#keyboard)
    - [USB-devices](#usb-devices)
    - [PCI-devices](#pci-devices)
11. [**Power**](#Power)
12. [**Remote Connections**](#remote-connections)
    - [Monitoring SSH](#monitoring-ssh)
13. [**Searching for stuff**](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/README.md#searching-for-stuff)
    - [Find](#find)
    - [Grep - utility for string and pattern matching](#grep---utility-for-string-and-pattern-matching)
      - [Locate a file](#locate-a-file)
      - [Whereis - locate the binary, source, and manual page files for a command](#whereis---locate-the-binary-source-and-manual-page-files-for-a-command)
      - [Which](#which)
      - [Zgrep - search within compressed files](#zgrep---search-within-compressed-files)
14. [**Shortcuts**](#Shortcuts)
15. [**Text**](#text)
16. [**Time and date**](#time-and-date)
17. [**Users and groups**](#users-and-groups)
    - [Passwords](#passwords)
    - [Run script with another users privileges](#run-script-with-another-users-privileges)
    - [Shell](#shell)
    - [User info](#user-info)
18. [**Variables and Scripting**](#variables-and-scripting)

<br >
<br >

## CDROM
- Create an iso file: `genisoimage -o image.iso -r /path/to/dir`
### Add virtual CDROM
- [CDEmu](https://cdemu.sourceforge.io)
````shell
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
````shell
[root@pc ~]# isoinfo -d -i /dev/sr1 | grep -i -E 'block size|volume size'
Logical block size is: 2048
Volume size is: 350320
[root@pc ~]#
````
2. Write the CD/DVD to a location and specify the volume size:
````shell
[root@pc ~]# dd if=/dev/sr1 of=/mnt/folder/test.iso bs=2048 count=350320
350320+0 records in
350320+0 records out
700640 bytes (700 MB) copied, 72.405 s, 10.4 MB/s
[root@pc ~]#
````
3. Verify that the written iso file has the same checksum as the CD/DVD
````shell
sha256sum /mnt/folder/test.iso      #E.g. c58ea020874bae8712d5715a...
sha256sum /dev/sr0                  #E.g. c58ea020874bae8712d5715a...
````

## Jobs/schedule a task with Crontab
- [Crontab Calculator](https://crontab.guru)
- [Crontab.cronhub.io](https://crontab.cronhub.io/)
Enter crontab: `crontab -e`
````shell
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
````shell
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
````shell
sudo apt install cron-apt
/etc/cron-apt/config            #configuration path
/etc/cron.d/cron-apt            #default crontab entry 
/usr/sbin/cron-apt              #testing cron-apt
````

### Downgrade or Upgrade
#### Downgrade to Ubuntu 18.04
1. Run `sed -i 's/cosmic/bionic/g' /etc/apt/sources.list`
2. Create the file `/etc/apt/preference` with the content
````shell
Package: *
Pin: release a=bionic
Pin-Priority: 1001
````
3. Run `sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y`
4. Enjoy

#### Upgrade to new release
1. Update and start the process:
````shell
sudo apt update && \
sudo apt dist-ugprade && \
sudo apt autoremove -y && \
sudo apt autoclean
sudo do-release-upgrade -c    #c = checks for new version
sudo do-release-upgrade       #this might not always work because of dev branch
sudo do-release-upgrade -d    #i usually us this one :D
````
3. Now follow the prompts on screen. Cheers!


### PPA
- [Using PPA in Ubuntu Linux [Complete Guide]](https://itsfoss.com/ppa-guide/)

 ### Unattended Upgrades
 - [Documentation](https://wiki.debian.org/UnattendedUpgrades)
 - [Enable-Automatic-Updates.sh](https://github.com/Am0rphous/Bash/blob/master/security/Enable-Automatic-Updates.sh) - Script that automatic install and enable automatic updates with smart settings.
 ````
 wget https://raw.githubusercontent.com/Am0rphous/Bash/master/security/Enable-Automatic-Updates.sh && bash Enable-Automatic-Updates.sh
 ````
 - [Unattended-upgrades](https://github.com/mvo5/unattended-upgrades) - Automatic installation of security upgrades on apt based systems.
   - [Debian - configured 50unattended-upgrades file](https://github.com/Am0rphous/CheatSheets/blob/main/Debian/50unattended-upgrades)
   - [Debian - configured 20auto-upgrades file](https://github.com/Am0rphous/CheatSheets/blob/main/Debian/20auto-upgrades)
   - [How to run unattended-upgrades not daily but every few hours](https://unix.stackexchange.com/questions/178626/how-to-run-unattended-upgrades-not-daily-but-every-few-hours)
 - [What's the difference: Security, Updates, Proposed & Backports in '50unattended-upgrades'](https://askubuntu.com/questions/401941/what-is-the-difference-between-security-updates-proposed-and-backports-in-etc)
1. Installation
 ````shell
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
````shell
sudo cat /var/log/unattended-upgrades/unattended-upgrades.log
sudo tail -f /var/log/unattended-upgrades/unattended-upgrades.log
sudo grep 'linux-image' /var/log/unattended-upgrades/unattended-upgrades.log
````
 
## File Permissions and Ownership
- [Linux File Permissions and Ownership Explained with Examples](https://linuxhandbook.com/linux-file-permissions/)
````shell
chattr -R folder                #chattr=manipulate attributes. R=recursively.
lsattr file/folder              #list attributes. R=Recm V=verbose, a=list all files
````

  ### Files and Folders
  - Linux Directory Structure and Important Files Paths Explained](https://www.tecmint.com/linux-directory-structure-and-important-files-paths-explained/)
````shell
ls folder|wc                                    #count files in folder
du -ah /|sort -rh|head -n 10                    #find largest  files on disk
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
  ````shell 
  touch /tmp/myfile                                       #choose a file to monitor
  sudo auditctl -w /tmp/myfile -p wa -k my-file-changed   #add audit for write and attribute change (-p wa)
  touch /tmp/myfile                                       #file is touched by user
  sudo ausearch -k my-file-changed -i | tail -1           #check audit logs:
  ````

  #### File compression
File compression's main advantage is when transferring files. Transfering 100 1KB files takes longer than transfering one 100 KB size file.
````shell
7z x archive.7z                             #sudo apt install p7zip-full
7za a -t7z data.txt.7z data.txt
7za a -tzip -p -mem=AES256 secure_folder.zip my_folder  #encrypts folder
bzip2 -zk data.txt
gpg -c your.zip                             #encrypt with gpg
gpg your.zip.gpg                            #decrypt with gpg
gzip -k core.c                              # compress core.c file and removes the original file
gzip -c data.txt > data.txt.gz
xz -zk data.txt                            #usually installed as default, if not: sudo apt install xz-utils
tar -cf data.txt.tar data.txt
tar -xf file.tar.xz                         # x = extract. f=filename
tar -xvfz file.tar/file.tgz                 # extracts .tar or .tgz files
tar -xf file_name.tar -C /target/folder     # extracts to new folder
zip --encrypt file.zip files                #encryption. Install with: sudo apt-get install zip
zip --encrypt file.zip -r your_folder       #encrypts folder
zip --password (password) file.zip files    #insecure, as the password will be in the terminal history

````
Extract each file to new folder with same name
````shell
for i in *.zip; do unzip "$i" -d "${i%%.zip}"; done
````

  #### File hashing
  ````shell
for i in *; do shasum -a 256 $i; done;
sha256sum *
shasum -a 256 *
  ````

  #### Find large files and Folders
  ````shell
  ncdu                                 #apt install ncdu
  du -d 1 -h
  du -hsx * | sort -rh | head -10
  du -hs * | sort -rh | head -n 10
  du -a /var | sort -n -r | head -n 10
  cd /path/to/directory && du -hsx * | sort -rh | head -10
  sudo du -a /home | sort -n -r | head -n 10
  find / -size +100M -ls
  find / -size +100M -size -200M -ls
  sudo find / -type f -printf “%s\t%p\n” | sort -n | tail -1
  find $HOME -type f -printf ‘%s %p\n’ | sort -nr | head -10
  ````
  Find top 10 files and directories consuming maximum disk space [source](https://sourcedigit.com/24840-how-to-find-large-files-in-linux-ubuntu/)
  ````shell
  alias ducks='du -cks * | sort -rn | head'
  ducks
  ````

## Help
- Emergency (minimal environment) `sudo systemctl emergency`
- [Linux User and Programmer's Manual - Manpages](https://www.systutorials.com/docs/linux/man/)
- Reverse search in terminal press `CTRL+R`
````shell
which <command>             #locate command path
which ls
<command> -h / --help
apropos <command>           #if you dont remember the exact command
apropos network             #find commands related to network
whatis <command>            #explains a command with a one-liner
tldr <command>              #NICE - a must! https://tldr.sh
man <command                #opens manual for 'command'. Check out manpages.org
man ipconfig                #opens manual for the 'ipconfig' command
man -k ssh                  #Search man
type alias/ls/ifconfig      #determining Type of command

help <command>
help cd
cheat <command>
info <command>
ls /usr/share/doc/
python3 -m pydoc socket     #python help
````

### History
````
history                #shows history of commands
echo $HISTFILE         #show history file location
echo $HISTFILESIZE     #number of commands stored
!!                     #run last command again
lsw
^lsw^ls                #if you wrote "lsw" as previous cmd which is wrong, fix it and run ls.
history | grep ls      #lists every ls command
history -d 1200        #delete command number 1200
history -d 1100-1200   #deletes commands between these numbers
````

### Man - Searching Man pages
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
- [A Guide to Compiling the Linux Kernel All By Yourself](https://itsfoss.com/compile-linux-kernel/)
- [Linux-kernel-module-cheat](https://github.com/cirosantilli/linux-kernel-module-cheat)

- [Kernel Hacking Guides](https://www.kernel.org/doc/html/latest/kernel-hacking/index.html)
  - [Collection of scripts for kernel-related devops](https://github.com/Notselwyn/kernel-scripts) - A curated collection of scripts for kernel-related devops
  - [kernelnewbies.org](https://kernelnewbies.org)

- [Kernel spoofer](https://github.com/milabs/kiddy)
- [Kernel Map](https://github.com/makelinux/linux_kernel_map) - [Diagram](https://makelinux.github.io/kernel/diagram/) and [map](https://makelinux.github.io/kernel/map/)
Commands
````
cat /proc/version
uname -a
uname -r                            #kernel version
uname -sr                           #kernel name and version
dpkg --list | grep linux-image      # list installed kernels
````

### Kernel Modules
- Pieces of code that we can load into the Linux kernel to extend its functionality. We can for instance capture detailed information about processes such as its creation, execution, termination, process IDs, system calls and a lot more.
````
lsmod          # list kernel modules
modprobe       # add/remove kernel modules
insmod         # insert module in kernel. USE MODPROPE INSTEAD!
modinfo        # show kernel module info
````

  ### Kernel Security
  - [Cloudflare - Linux kernel hardening](https://blog.cloudflare.com/linux-kernel-hardening/)
  - [AppArmor](https://www.apparmor.net) - MAC style security extension for the Linux kernel.
    - [AppArmor GitLab](https://gitlab.com/apparmor)
    - [Apparmor Ubuntu Docs](https://ubuntu.com/server/docs/security-apparmor)
    - [Documentation](https://www.kernel.org/doc/html/latest/admin-guide/LSM/apparmor.html)
  ````shell
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
  ````shell
  for mod in $(lsmod | tail -n +2 | cut -d' ' -f1); do modinfo ${mod} | grep -q "signature" || echo "no signature for module: ${mod}" ; done
  ````
   Checks if Secure Boot is enabled:
   ````shell
   sudo mokutil --sb-state
   ````

  ### Kernel Install/Removal
  - [Source for commands: askubuntu.com(...)](https://askubuntu.com/questions/1207958/error-24-write-error-cannot-write-compressed-block)
  - Don't touch these packages
````shell
dpkg -l | egrep "linux-(signed|modules|image|headers)" | grep $(uname -r)
````
List all kernels installed on system
````shell
#ii = installed and expected
dpkg --list 'linux-image-*' | grep ^ii

uname -r     #Running kernel in use - Don't remove this one

#List kernels not being used. Usually these are only older kernels - unless you've changed during boot to an older kernel version
# then you will show the newest kernel as well. Obviously dont remove the newest one.
dpkg -l | egrep "linux-(signed|modules|image|headers)" | grep -v $(uname -r | cut -d - -f 1)
````
Lets do some removing/purging
````shell
#Only remove a specific kernel - safe
apt purge linux-image-6.6.9-amd64

#Purge all the unused kernels. Might remove newest kernel also
dpkg -l | egrep "linux-(signed|modules|image|headers)" | grep -v $(uname -r | cut -d - -f 1) | awk {'print $2'} | xargs sudo apt purge -y
````
  #### Install custom kernel
  - Identify what kernel you are using with `uname -r` and list installed kernels: `dpkg --list | grep linux-image`
  - Find the kernel you want at [https://kernel.ubuntu.com/mainline/](https://kernel.ubuntu.com/mainline/)
  - Download both the header and the image file. Install with `sudo dpkg -i *.deb`
  - For [Kali](https://www.kali.org/docs/development/recompiling-the-kali-linux-kernel/):
````
#1. Download e.g. 6.11 from https://www.kernel.org
tar -xvf linux-6.11.tar.xz
cd linux-6.11
sudo apt install -y build-essential libncurses5-dev fakeroot xz-utils
#maybe: sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev
#use standard config from current kernel
cp /boot/config-$(uname -r) .config
make clean
make deb-pkg LOCALVERSION=-custom KDEB_PKGVERSION=$(make kernelversion)-1
ls ../*.deb
sudo dpkg -i ../linux-image-4.9.0-kali1-custom_4.9.2-1_amd64.deb
reboot

#maybe:
sudo make modules_install
sudo make install
sudo update-grub
sudo reboot
````

## Peripherals
### keyboard
- Change of keyboard language can be a pain in the ass 
  ````shell
  sudo apt install --reinstall console-setup keyboard-configuration  # Ensure these packages are installed
  sudo dpkg-reconfigure keyboard-configuration                       # Now lets reconfigure the keyboard

  # Troubleshooting
  localectl status   #Current keyboard settings
  localectl list-x11-keymap-layouts|grep no     # Checks if "no" is available
  loadkeys no                                   # Adjust to e.g. Norwegian
  
  sudo localectl set-keymap <keymap>
  sudo localectl set-keymap no          # Norwegian
  sudo apt install x11-xkb-utils
  setxkbmap -layout no
  sudo localectl set-keymap no
  ````

### USB-devices
- [Change mouse scroll wheel speed](https://askubuntu.com/questions/1388038/how-to-get-smooth-scroll-with-logitech-mouse)
- [USBGuard](https://github.com/USBGuard/usbguard) - USBGuard is a software framework for implementing USB device authorization policies (what kind of USB devices are authorized) as well as method of use policies (how a USB device may interact with the system).
- [Usbrip](https://github.com/snovvcrash/usbrip) - Tracking history of USB events on GNU/Linux.
- [Usbtop](https://github.com/aguinet/usbtop) - usbtop is a top-like utility that shows an estimated instantaneous bandwidth on USB buses and devices. 
````shell
sudo blkid
lsusb
ls /proc/bus/usb
lspci
usb-devices 
````
#### Webcam
````shell
sudo apt-get install v4l-utils
v4l2-ctl --list-devices
v4l2-ctl --list-formats-ext
````
Play from webcam
````shell
sudo apt install ffmpeg
ffplay /dev/video0
````
### PCI-devices
Listing PCI devices

````shell
sudo lspci
````



## Searching for stuff

  ### Find
````shell
  find filename
  find / -empty               #searches for empty files and folders in your system
  find ~ filename             #searches through the active user's home folder
  find . filename             #searches through current and nested folders
  find / filename             #searches from root directory
  find / -executable          #searches for executable files
  find / -name *.mp3          #searches for files with .mp3 extension
  find / -user mike -ls 2>/dev/null                             #search for files owned by this user
  find / -name myfile -exec nano '{}' \;                        #searches for files with 'myfile' names and opens nano
  find . -name sample.txt -exec rm -i {} \;                     #finds sample.txt and asks if you want to remove it
  find . -name '*(1).*' -exec mv "{}" ../folder \;              #moves files containing (1) to the folder 'folder'
  find / -name '*.conf' -mtime -90 -exec grep mystring {} +     #finds every config file newer then 60 days, then grep for 'mystring'
  ````
- [fd](https://github.com/sharkdp/fd) - A simple, fast and user-friendly alternative to 'find'

### Grep - utility for string and pattern matching
- [grep](https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/%20)
````zsh
grep -r testing                             # grep recursivly
grep -i test                                # i= ignore case
grep -R -i memfree .                        # R = recursive dereference
grep -r --include "*.txt" /mycode/          
grep -rn "eth0" /etc                        # recursive + displays line
grep -q error syslog.log                    # silence the output
echo $?                                     # results in 0 or 1 depending on true or false
grep -E -w -i "failed|error" syslog.log     # E=search for multiple words
grep -v Error syslog.log                    # Exclude "Eroror from output
grep -Evi "sUcCeSs|waRning" syslog.log      # Removes success or warning
````
Extract IP-addresses from a file [source](https://github.com/dwisiswant0/awesome-oneliner-bugbounty)
`grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' MYFILE.txt`

#### Locate a file
````shell
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
````shell
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
````
sudo pwrstat -status
````
- [Powerstat](https://github.com/ColinIanKing/powerstat) - Powerstat measures the power consumption of a machine using the battery stats or the Intel RAPL interface. The output is like vmstat but also shows power consumption statistics. At the end of a run, powerstat will calculate the average, standard deviation and min/max of the gathered data.
````
sudo powerstat -R
````
- [UPower](https://upower.freedesktop.org) - UPower is an abstraction for enumerating power devices, listening to device events and querying history and statistics.
 ````shell
upower -i /org/freedesktop/UPower/devices/battery_BAT0
upower -i /org/freedesktop/UPower/devices/battery_BAT1

acpi                               #shows battery status and other ACPI information
acpi -i -b                         # -ib also works
sudo lshw -c power
sudo dmidecode --type 39           #DMI table decoder
ls -l /sys/class/power_supply/AC
 ````
 - Enable powersaving for disks:
````shell
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
````shell
ssh username@domain.com
ssh username@ip
ssh -D 127.0.0.1:9050 target.com      #ssh through local tor proxy
ssh -p 1234 user@domain
ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -b 4096 -t rsa
ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -b 521 -t ecdsa
xfreerdp /u:Admin +clipboard /w:1280 /h:1024 /v:SERVER_IP
ssh user@IP 'echo "rootPassword" | sudo -Sv && bash -s' < local-computer-script.sh
````
### Monitoring SSH
````shell
last -a | grep -i still
netstat -tnpa | grep 'ESTABLISHED.*sshd'
ps auxwww | grep sshd: | grep -v grep
ps -fC sshd
ss | grep -i ssh
w
who
````


## Shortcuts
- [21 Useful Terminal Shortcuts](https://itsfoss.com/linux-terminal-shortcuts/)

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

````shell
cat file.log | sed -r 's/^.{3}//'       #removes three first characters of each line
````

Sorting (sources [1](https://stackoverflow.com/questions/15984414/bash-script-count-unique-lines-in-file),
````shell
sort ips.txt | uniq -c
sort ips.txt | uniq -c | sort -bgr
````
Counting number of uniqe lines
````shell
sort ips.txt | uniq | wc -l
awk '!seen[$0]++' ips.txt | wc -l
````
- Sorting list of names
````
sort names.txt
sort -u names.txt     #removes duplicate lines
````

## Time and date
- [Tzupdate](https://github.com/cdown/tzupdate) - Set the system timezone based on IP geolocation.
````shell
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
````shell
groups                              # lists groups for the current user
groups peter                        # lists groups for specific user
su - peter                          # switch to user peter
sudo adduser mike                   # USE THIS COMMAND! Adds a new user. Creates home folder ++. More user friendly
sudo useradd                        # low level. Scripting?
sudo usermod -aG sudo mike          # adds group sudo to the user "mike"
last -x                             # This will tell you last shutdown time
last -x reboot                      # This will tell you last shutdown time
lastb
lastlog
lastlog -u mike
sudo lastlog --clear --user mike
lastlog --user mike         #verify
````
sudoers: `/etc/sudoers`
````
sudo touch /etc/sudoers.d/peter
echo "peter  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/peter
````
  ### Passwords
  - [XKCD Password Generator](https://github.com/redacted/XKCD-password-generator) - Generate secure multiword passwords/passphrases, inspired by XKCD.
  ````shell
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
````shell
su -c "/usr/bin/executable" -s /bin/sh username
````
## Shell
- List all available shells on your system: `cat /etc/shells`
- Change a users Shell:
````shell
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


## Variables and Scripting
- [Am0rphous -> Bash](https://github.com/Am0rphous/Bash)
- echo `printenv`
- Update $PATH with
  ````shell
  1. Append: export PATH=$PATH:/new/path/

  2. nano ~/.bash_profile    #kali .profile
  export PATH=$PATH:/usr/local/android-studio/bin/     #Add line and save
  source ~/.bash_profile   #kali: source .profile
  ````
- `bash -n scriptname` checks if a script got syntax error
- [Learn Bash Scripting ](https://itsfoss.com/create-bash-script/)
- `$PATH` a variable that contains the path to all locations on where to find commands and programs. NB: If this variable contains two different paths for the same executable, the first path in `$PATH` will be used.
  ````shell
  printenv
  read -p "Write the path: " variableName
  ````
  
### Make a script exit when a command fail
In Bash scripting, you can make a script exit immediately when a command fails by using the "set -e" or "set -o errexit" option. This option tells the shell to exit if any command in the script returns a non-zero exit status, indicating a failure.
````shell
set -e
set -u
set -o errexit  #means the same as the first (set -e)
set -o nounset  #means the same as the second (set -u)
````




