# Disk

- [Create Bootable USB](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#creating-bootable-usb)
- [Dd - Backup and Recovery](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#dd---backup-and-recovery)
- [Fix bad/corrupted disks / file systems](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#fix-badcorrupted-disks--file-systems)
- [Listing](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#listing)
- [LVM](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#lvm)
- [Format](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#format)
- [Monitoring](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#monitoring)
- [Mounting / Unmounting](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#mounting--unmounting)
  - [Mounting a NAS Synology server with IP 10.0.0.10 to Ubuntu](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#mounting-a-nas-synology-server-with-ip-100010-to-ubuntu)
  - [Mounting Encrypted Drives](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#mounting-encrypted-drives)
- [Scanning for new disks](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#scanning-for-new-disks)
- [SDInfo](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#sdinfo)
- [Secure Deletion](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#secure-deletion)
- [ZFS](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#zfs)

To list size of each folder and sort the result, run this command:
````powershell
du -smh * | sort -nr
````

## Creating Bootable USB
````powershell
sudo umount /dev/sdb*
sudo mkfs.vfat /dev/sdb –I
sudo dd if=~/Downloads/iso/Ubuntu.iso of=/dev/sdb
#OR
sudo dd if=ubuntu.iso of=/dev/sdb status=progress oflag=sync bs=4M
sudo dd bs=4M if=kali.iso of=/dev/sdd conv=fdatasync status=progress
````
Monitor the progress
````powershell
pgrep –l ‘^dd$’
kill –USR1 3443         #3443 is the dd process id. It will print copying process statics.
````

## Dd - Backup and Recovery
````powershell
sudo dd if=/dev/sdb status=progress | gzip -c > /mnt/backup.img.gz
sudo dd if=/dev/sda of=/media/disk.img bs=1M conv=noerror,sync status=progress
sudo dd if=/dev/sda3 conv=sync,noerror bs=2M | split -a 3 -d -b 1G - /maindisk.img
sudo ddrescue -D -f -n -v /dev/nvm /media/img.img /media/ddrescue.log         
````
### ddrescue
- ddrescue -D -f -n -v /dev/nvm /media/img.img /media/ddrescue.log   
  - D = Short for ‘–synchronous’. This issues an fsync call after every write.
  - f = Force ddrescue to run even if the destination file already exists (this is required when writing to a disk). It will overwrite.
  - n = 
  - -v = verbose

## Encrypting Disk
- [crypt-partition](https://github.com/r3nt0n/crypt-partition) - Partition encrypt tool via shellscript and cryptsetup 

## Fix bad/corrupted disks / file systems


<details>
   
<summary>badblocks - search a device for bad blocks </summary>

```
man fsck
badblocks --help
sudo badblocks -s /dev/sda      # show progress percentage when doing read-only test
sudo badblocks -v /dev/sda
sudo badblocks -sn /dev/sdd     # performs a non-destructive read-write test. This does NOT erase data.
sudo badblocks -sw /dev/sdd     # CAREFUL: ERASES data when performing read-write test. 
```

</details>

<details>
   
<summary>fsck - check and repair a Linux filesystem </summary>

```
man fsck
fsck --help
sudo fsck -A                # checks every file system in /etc/fstab
sudo fsck -v -a /dev/sda    # verbose + auto fix
sudo touch /forcefsck       # force file system check at next reboot
sudo fsck /dev/sdb          # checks disk /dev/sdb
sudo fsck -y /dev/sdb       # yes fix errors
```

</details>



## Listing
- Commands
````powershell
cat /etc/fstab 
sudo blkid                #locate/print block device attributes
sudo blkid -p /dev/sda1
findmnt                   #find a filesystem
lsblk               
ls -l /dev/disk/by-       #inspect the directories
mount
````

## LVM
- [How to Extend/Reduce LVM’s (Logical Volume Management) in Linux – Part II](https://www.tecmint.com/extend-and-reduce-lvms-in-linux/)
- [Lvextend command examples in Linux](https://www.thegeekdiary.com/lvextend-command-examples-in-linux/)
````powershell
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
- Try this first `sudo resize2fs -p /dev/mapper/ubuntu--vg-ubuntu--lv`
- and this `lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv`

## Format
````powershell
mkfs.ext4 /dev/sdb1
````

## Monitoring
- [IoTop](https://github.com/Tomas-M/iotop) - A top utility for IO.
- sysstat - `sudo apt install sysstat` which has the program `iostat` with it:
````
iostat -y 1       # get continuous output of all disk activity, which updates every 1 second
iostat -y 1 -m    # same as above, but listing in Megabytes in stead og Kilobytes
````
- iotop - Install with `sudo apt install iotop` and run it: `iotop`

## Mounting / Unmounting
````powershell
sudo mount /dev/sda /media/storage
sudo umount /dev/sda /media/ubuntu
sudo mount -a                              #mount all partitions from /ect/fstab
````
### Mounting a NAS Synology server with IP 10.0.0.10 to Ubuntu
On Ubuntu do:
````powershell
sudo apt-get install nfs-common
sudo mkdir /mnt/storage
mount 10.0.0.10:/volume1/storage /mnt/storage
# /etc/fstab can look like this
10.0.0.10:/volume1/storage /mnt/storage nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800,rsize=8192,wsize=8192,timeo=14, 0 0
mount -a
df -h | grep 10.0.0.10
````
- [Common NFS Mount Options](https://web.mit.edu/rhel-doc/5/RHEL-5-manual/Deployment_Guide-en-US/s1-nfs-client-config-options.html)
On the NAS server do:
- Open Control Panel and click Create.
  - Give it a name, description
  - Unmark "Enable Recycle Bin"
  - Mark "Hide this shared folder in "my Network Places" and "Hide sub-folders and files from users without permissions.
  - Click "Ok".
- Go to "NFS persmission" tab and click "Create". Fill inn:
  - Hostname or IP      10.0.0.10
  - Privilege           Read/Write
  - Squash              No mapping
  - Security            sys
  - Enable asynchronous MARKED
  - Click "Ok".

### Mounting Encrypted Drives
````powershell
cryptsetup luksOpen /dev/sda3 mydisk--vg-root
mount /dev/mapper/krypto-root /mnt/secure
````

## Scanning for new disks
````powershell
ioscan -fnC disk
ls /sys/class/scsi_host
echo "- - -" > /sys/class/scsi_host/host[n]/scan
echo "- - -" > /sys/class/scsi_host/host0/scan
echo "- - -" > /sys/class/scsi_host/host1/scan
echo "- - -" > /sys/class/scsi_host/host2/scan
echo "- - -" > /sys/class/scsi_host/host3/scan
for i in {1..30}; do echo "- - -" > /sys/class/scsi_host/host$i/scan; done
````
## SDInfo
- [SDInfo](https://github.com/johnlane/sdinfo) - Display details about an SD Card.


## Secure Deletion
- dd
````powershell
dd if=/dev/zero of=/dev/sda2 bs=512 count=1
dd if=/dev/urandom of=/dev/sda2 bs=4096
````
- hdparm
````powershell
sudo hdparm --user-master u --security-set-pass foo /dev/sdX
sudo hdparm -I /dev/sdX                                         # frozen should be "not frozen"
#IF FROZEN DO THIS
echo -n mem > /sys/power/state
hdparm --user-master u --security-set-pass p /dev/sda
hdparm --user-master u --security-erase-enhanced p /dev/sda     # if the drive DOES support Enhanced Security Erase:
hdparm --user-master u --security-erase p /dev/sda              # if NOT
dd if=/dev/sda bs=1M count=5                                    # should output nothing og just jibberish
````
- scrub
````powershell
scrub /dev/sda5
scrub -p dod /dev/sda5 -f
````
- shred
````powershell
sudo shred -v /dev/sdX                                  # default is overwrite 3 times
sudo shred -v -n1 -z /dev/sdX                           # overwrite 1 time + z=zero out after
shred -v --random-source=/dev/urandom -n10 /dev/sda2    # write random data 10 times on disk sda2
````
- wipe
````powershell
wipe /dev/sda2
````

## ZFS
````powershell
zpool import NAME

````
