# Hardware

- [Linux-hardware.org](https://linux-hardware.org/) `sudo apt install hw-probe && sudo -E hw-probe -all -upload`
- [(Old) I-Nex](https://github.com/i-nex/I-Nex) - System information tool written in gambas3, python, bash. [i-nex.linux.pl](http://i-nex.linux.pl)


````
fwupdmgr get-devices    # get bios info
cat /proc/partitions
cat /proc/scsi/scsi
df #disk space of file systems
dmidecode
fdisk
free
free -m
hwinfo
inxi
inxi -Fx
lsblk
lscpu
lshw
lspci
lspci -v | grep "VGA" -A 12
lsscsi #List scsi devices
lsusb
mount
mount | column -t | grep ext
sudo hdparm -i /dev/sda

sudo dmidecode -s system-serial-number                                 #Servicetag to Dell server
sudo dmidecode | grep -A3 '^System Information' | grep 'Product Name'  #Server model
sudo dmidecode | less
````

## CPU - Central Processing Unit
- [i7z](https://archlinux.org/packages/community/x86_64/i7z/) - A better i7 (and now i3, i5) reporting tool for Linux
````shell
cpufetch                              # sudo apt install cpufetch    https://github.com/Dr-Noob/cpufetch
dpkg --print-architecture             # prints your currently CPU architecture
dpkg --print-foreign-architectures    # prints foreign architecture support

cpuid                               # Dump CPUID information for each CPU. sudo apt install inxi
lscpu                               # display information about the CPU architecture
inxi -C                             # display CPU information. sudo apt install inxi
nproc                               # print the number of processing units available
sudo dmidecode --type processor     # might want to use sudo
sudo hwinfo --cpu                   # sudo apt install hwinfo
sudo lshw -short
sudo lshw -C CPU

cat /proc/cpuinfo
cat /proc/cpuinfo | grep 'vendor' | uniq		      # view vendor name
cat /proc/cpuinfo | grep 'model name' | uniq		  # display model name
cat /proc/cpuinfo | grep processor | wc -l		    # ount the number of processing units
cat /proc/cpuinfo | grep 'core id'		          	# show individual cores
egrep -e "core id" -e ^physical /proc/cpuinfo | xargs -l2 echo | sort -u   #Sockets and cores
````
- Temperature
  - [Thermal Monitor](https://gitlab.com/agurenko/plasma-applet-thermal-monitor) - Plasma 5 applet for monitoring CPU, GPU and other available temperature sensors.
  - [Xsensors](https://github.com/Mystro256/xsensors) - a fork of Xsensors with various improvements (GTK3, cleanup, bugfixes, enhancements)

### Overclocking / CPU frequency scaling
- Check BIOS/UEFI first, not all motherboards and cpu's support over/downclocking
- [CPU frequency scaling](https://wiki.archlinux.org/title/CPU_frequency_scaling)
  ````shell
  #Stress testers
  stress
  stress-ng
  cpuburn
  stressapptest
  ````



