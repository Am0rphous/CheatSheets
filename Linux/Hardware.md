# Hardware

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
