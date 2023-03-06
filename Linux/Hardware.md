# Hardware

- [I-Nex](https://github.com/i-nex/I-Nex) - System information tool written in gambas3, python, bash. [i-nex.linux.pl](http://i-nex.linux.pl)
- [Linux-hardware.org](https://linux-hardware.org/)
  - [Dmesg reports](https://github.com/linuxhw/Dmesg) - Collect dmesg reports
 
Commands
````
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
````

## CPU - Central Processing Unit

- [i7z](https://archlinux.org/packages/community/x86_64/i7z/) - A better i7 (and now i3, i5) reporting tool for Linux

### Architecture
- [CPUFetch](https://github.com/Dr-Noob/cpufetch) - Simple yet fancy CPU architecture fetching tool. Supports x86, x86_64 (Intel and AMD) and ARM.
````powershell
dpkg --print-architecture             # prints your currently CPU architecture
dpkg --print-foreign-architectures    # prints foreign architecture support
````

### Commands
````powershell
cpuid                               # Dump CPUID information for each CPU. sudo apt install inxi
lscpu                               # display information about the CPU architecture
inxi -C                             # display CPU information. sudo apt install inxi
nproc                               # print the number of processing units available
sudo dmidecode --type processor     # might want to use sudo
sudo hwinfo --cpu                   # sudo apt install hwinfo
sudo lshw -short
sudo lshw -C CPU
````

### Overclocking / CPU frequency scaling
- Check BIOS/UEFI first, not all motherboards and cpu's support over/downclocking
- [CPU frequency scaling](https://wiki.archlinux.org/title/CPU_frequency_scaling)

### /proc/cpuinfo
````powershell
cat /proc/cpuinfo
cat /proc/cpuinfo | grep 'vendor' | uniq		      # view vendor name
cat /proc/cpuinfo | grep 'model name' | uniq		  # display model name
cat /proc/cpuinfo | grep processor | wc -l		    # ount the number of processing units
cat /proc/cpuinfo | grep 'core id'		          	# show individual cores	
````

### Stress testers
````
stress
stress-ng
cpuburn
stressapptest
````

### Temperature
- [Thermal Monitor](https://gitlab.com/agurenko/plasma-applet-thermal-monitor) - Plasma 5 applet for monitoring CPU, GPU and other available temperature sensors.
- [Xsensors](https://github.com/Mystro256/xsensors) - a fork of Xsensors with various improvements (GTK3, cleanup, bugfixes, enhancements)


