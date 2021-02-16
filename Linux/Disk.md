# Disk

## Creating Bootable USB
- dd
````
sudo umount /dev/sdb*
sudo mkfs.vfat /dev/sdb –I
sudo dd if=~/Downloads/iso/Ubuntu.iso of=/dev/sdb
#OR
sudo dd if=ubuntu.iso of=/dev/sdb status=progress oflag=sync bs=4M
````
Monitor the progress
````
pgrep –l ‘^dd$’
kill –USR1 3443         #3443 is the dd process id. Iit will print copying process statics.
````

### fschk - file system consistency check
Remember to unmount disk before checking. e.g. `umount /dev/sdb`
| Key/Command | Description |
| ----------- | ----------- |
| man fschk | displays manual |
| fchk /dev/sdb | checks disk /dev/sdb |
| fchk -y /dev/sdb | corrects errors automatically. y=yes |
| fchk -A | checking all filesystems. The list is taken from /etc/fstab |
| touch /forcefchk | forces computer to check disk at next reboot |

###LVM
````bash
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

###Format
````
mkfs.ext4 /dev/sdb1
````

###Mounting / Unmounting
````
sudo mount /dev/sda /media/storage
sudo umount /dev/sda /media/ubuntu
sudo mount -a                              #mount all partitions from /ect/fstab
````
###Mounting a NAS Synology server with IP 10.0.0.10 to Ubuntu
On Ubuntu do:
````zsh
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

###Scanning for new disks
````
ioscan -fnC disk
ls /sys/class/scsi_host
echo "- - -" > /sys/class/scsi_host/host[n]/scan
echo "- - -" > /sys/class/scsi_host/host0/scan
echo "- - -" > /sys/class/scsi_host/host1/scan
echo "- - -" > /sys/class/scsi_host/host2/scan
echo "- - -" > /sys/class/scsi_host/host3/scan
````
