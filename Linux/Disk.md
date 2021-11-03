# Disk

- [Create Bootable USB](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#creating-bootable-usb)
- [Dd - Backup and Recovery](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#dd---backup-and-recovery)
- [Fschk - file system consistency check](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#fschk---file-system-consistency-check)
- [LVM](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#lvm)
- [Format](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#format)
- [Mounting / Unmounting](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#mounting--unmounting)
  - [Mounting a NAS Synology server with IP 10.0.0.10 to Ubuntu](https://github.com/Am0rphous/CheatSheets/blob/main/Linux/Disk.md#mounting-a-nas-synology-server-with-ip-100010-to-ubuntu)
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

## Fschk - file system consistency check
Remember to unmount disk before checking. e.g. `umount /dev/sdb`
| Key/Command | Description |
| ----------- | ----------- |
| man fschk | displays manual |
| fchk /dev/sdb | checks disk /dev/sdb |
| fchk -y /dev/sdb | corrects errors automatically. y=yes |
| fchk -A | checking all filesystems. The list is taken from /etc/fstab |
| touch /forcefchk | forces computer to check disk at next reboot |

## LVM
- [How to Extend/Reduce LVM’s (Logical Volume Management) in Linux – Part II](https://www.tecmint.com/extend-and-reduce-lvms-in-linux/)
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

## Format
````powershell
mkfs.ext4 /dev/sdb1
````

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
cryptsetup luksOpen /dev/sda2 secure
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
