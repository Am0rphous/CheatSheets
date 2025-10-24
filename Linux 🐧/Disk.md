# Disk

````shell
df -h
lsblk
blkid -p /dev/sda1
lsblk -d -o NAME,MODEL   #List disk model
lshw -class disk         #lsit complete disk model info

cat /etc/fstab 
mount
ls -l /dev/disk/by-       #inspect the directories
findmnt                   #find a filesystem
findmnt -no UUID -T /swapfile    #list UID
````

<details> <summary> Sort folders by size </summary>

```
du -smh * | sort -nr
```

</details>

<details> <summary> Create a bootable USB </summary>

````shell
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

</details>

<details><summary> Backup and Disk recovery </summary>


````shell
sudo dd if=/dev/sdb status=progress | gzip -c > /mnt/backup.img.gz
sudo dd if=/dev/sda of=/media/disk.img bs=1M conv=noerror,sync status=progress
sudo dd if=/dev/sda3 conv=sync,noerror bs=2M | split -a 3 -d -b 1G - /maindisk.img   
````
By using `ddrescue`
- Install with `sudo apt install gddrescue`
- Then run `ddrescue -D -f -n -v /dev/nvm /media/img.img /tmp/ddrescue.log`
  - D = Short for ‘–synchronous’. This issues a fsync call after every write.
  - f = Force ddrescue to run even if the destination file already exists (this is required when writing to a disk). It will overwrite.
  - n = skip scraping phase
  - v = verbose

</details>

<details> <summary> Secure disk wiping </summary>

dd - Not recommended on SSDs due to wear level
````shell
dd if=/dev/zero of=/dev/sda2 bs=512 count=1
dd if=/dev/urandom of=/dev/sda2 bs=4096
````
hdparm - Recommended!
````shell
sudo hdparm --user-master u --security-set-pass foo /dev/sdX
sudo hdparm -I /dev/sdX      #frozen should be "not frozen"

#If frozen run:
echo -n mem > /sys/power/state   #Screen will black out for 2 seconds. Stay calm.

hdparm --user-master u --security-set-pass random123 /dev/sda         #sets a password.
hdparm --user-master u --security-erase-enhanced random123 /dev/sda   #if the drive DOES support Enhanced Security Erase:

#If enhanced is not supported run:
hdparm --user-master u --security-erase random123 /dev/sda            #If NOT

fstrim /dev/sda  #discard unused blocks - nice!
dd if=/dev/sda bs=1M count=5                                    # should output jibberish
````
scrub
````shell
scrub /dev/sda5
scrub -p dod /dev/sda5 -f
````
shred
````powershell
sudo shred -v /dev/sdX                                  # default is overwrite 3 times
sudo shred -v -n1 -z /dev/sdX                           # overwrite 1 time + z=zero out after
shred -v --random-source=/dev/urandom -n10 /dev/sda2    # write random data 10 times on disk sda2
````
wipe
````shell
wipe /dev/sda2
````

</details>

### Encrypting Disk
- [crypt-partition](https://github.com/r3nt0n/crypt-partition) - Partition encrypt tool via shellscript and cryptsetup 

### LUKS (Linux Unified Key Setup)

<details> <summary> Error (April 2025) - "cryptsetup: Waiting for encrypted source device UUID=(..)" </summary>


#### Error April 2025 - "cryptsetup: Waiting for encrypted source device UUID=(..)"
**Pre note:** This was a pain in the ass. After troubleshooting for a week i finally identifiet the error. I write this as none of the sources on the Internet had anything pointing to the solution i discovered. Ensure the file /etc/cryptsetup exists - mine was deleted. Ensure it has this content
````
cryptsetup
````

- **Background:** I run Kali as my Desktop. Ofc I run encrypted drives on my NVME-disk. They were created when setting up the machine. Why and how my crypt setup failed remains unclear - when though i suspect updates - but i cannot confirm this.
- **The error:** After a couple of weeks without using the computer, I was surprised when i booted up the computer. Normally Grub chooses the first alternative in the Grub bootloader menu and proceeds to decrypt the drive. But instead of decrypting it, the following error occured _"Waiting for encrypted source device UUID=(..)"_ which contained the UUID for the crypt partition on my physical disk. The system then booted straight into an initramfs-shell without any attached keybord functioning - not good - and impossible to troubleshoot when unable to use a shell/keyboard.

#### Troubleshooting steps
- People on the Internet experienced similar symptoms. Usually this problems happens when UUIDs change on disks - fair enough to fix. This is easy to check when booting a live USB and running `sudo blkid` which shows UUIDs for all disks/partitions. You can check with the following
1. `/etc/fstab` contains a line looking something like:
````
#Example 1:
#/boot/efi partition - /dev/sda1
/dev/disk/by-uuid/PR21-558F /boot/efi vfat defaults 0 0
#/boot partition - /dev/sda2
/dev/disk/by-uuid/3a074af5-1468-4417-9866-4ce9a78f3690 /boot ext4 defaults 0 0
#/ partition - /dev/ubuntu-vg/ubuntu-lv
/dev/disk/by-id/dm-uuid-LVM-a7XMZRjlQWoXEycBMFV1nI54Kn2ls0e8FmM2Njq4HJuGLLHkHhnk5WAcsWEtD1QU / ext4 defaults 0 0

#Example 2 - or looking like these
/dev/mapper/pc--vg-root / ext4 errors=remount-ro 0 1
````
2. `/etc/crypttab` contains a line when UUID matching "crypto_LUKS" partition
````
#Example 1
dm_crypt-0 UUID=282a96b2-6ae7-4d74-8c7e-fdab5fc44bda none luks

#Example 2
````
3. Check `/boot/grub/grub.cfg` contains the correct UUID for root file system /dev/mapper/pc--vg-root
4. Run `sudo update-grub` and then `sudo update-initramfs -u -k all` which updates boot images

#### Mounting a system within a live USB to work on it
After booting into a Live USB mount following partitions to be able to work with the old system. This assumes you've LUKS encrypted the disk.
````
 #EXAMPLE
sudo cryptsetup open /dev/SYSTEM_PARTITION encrypted_disk

#Actual command
sudo cryptsetup luksOpen /dev/nvme0n1p3 nvme0n1p3_crypt
sudo mount /dev/mapper/pc--vg-root /mnt
sudo mount /dev/nvme0n1p2 /mnt/boot
sudo mount /dev/nvme0n1p1 /mnt/boot/efi

sudo mount --bind /dev /mnt/dev
sudo mount --bind /dev/pts /mnt/dev/pts
sudo mount --bind /run /mnt/run
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys

#Important to chroot into the system
sudo chroot /mnt

#RUN ALL YOUR COMMANDS HERE - e.g. updating/removing packages..

#After you've done - run this:
update-initramfs -u
exit   #1 - exit chroot
exit   #2 - exit root shell
````
Then unmount disk
````
sudo umount /mnt/dev/pts
sudo umount /mnt/dev
sudo umount /mnt/proc
sudo umount /mnt/sys
sudo umount /mnt/boot/efi
sudo umount /mnt/boot
sudo umount /mnt
````
</details>

### Fix corrupted disks/system
- Signs of bad disk: Slow performance, crashes/errors, startup problems, files disappear/becomes corrupt, strange noises (spinning disks, electricity)
- Smartmonctl
````shell
sudo apt update && sudo apt install smartmontools
smartctl -i /dev/sda
smartctl -a /dev/sdb        # Get full report
smartctl -s on /dev/sdX     # Enable SMART on a drive
smartctl -t short /dev/sdX  # Quick health check
smartctl -t long /dev/sdX   # Comprehensive
smartctl -l error /dev/sdX  # Check errors

smartctl -H /dev/nvme0n1    # Check Health
smartctl -l error /dev/nvme0n1

nvme smart-log /dev/nvme0n1   #apt install nvme-cli
nvme error-log /dev/nvme0n1
````

<details>
   
<summary>badblocks</summary>

Search for corrupted blocks

```
man fsck
badblocks --help
sudo badblocks -s /dev/sda      # show progress percentage when doing read-only test
sudo badblocks -v /dev/sda
sudo badblocks -sn /dev/sdd     # performs a non-destructive read-write test. This does NOT erase data.
sudo badblocks -sw /dev/sdd     # CAREFUL: ERASES data when performing read-write test. 
```

</details>

<details><summary> fsck </summary>

File System Consistency Check

````
man fsck
fsck --help
sudo fsck -A                # checks every file system in /etc/fstab
sudo fsck -v -a /dev/sda    # verbose + auto fix
sudo touch /forcefsck       # force file system check at next reboot
sudo fsck /dev/sdb          # checks disk /dev/sdb
sudo fsck -y /dev/sdb       # yes fix errors
````

</details>

<details><summary> Repair ext4 superblock </summary>

- [source](https://github.com/tomwechsler/Linux_command_line_for_beginners/blob/main/repairing_ext4_superblock.txt)

```
#If you want to do this on a test partition, use the following command (note: substitute the path to your test partition).
sudo dd if=/dev/urandom of=/dev/sdb2 bs=1k seek=10 count=4k

#Now we list all block devices (it needs elevated rights for this):
sudo lsblk
sudo dump2fs /dev/sde2 | grep uperblock (I write "uperblock" because I don't know if it's upper or lower case ;-)
sudo fsck /dev/sdb2 (We could try to repair the partition directly => BUT, we are looking for the superblocks)
sudo mkfs.ext4 -n /dev/sdb2 (ATTENTION: be sure to use -n!!!! without -n you create a new file system!!) => now we see the superblocks
sudo fsck -b 40961 /dev/sdb2 (after -b insert a superblock from above)

#If the first superblock does not work use the next one.
sudo fsck /dev/sdb2
```

</details>


### Working with LVM
- [How to Extend/Reduce LVM’s (Logical Volume Management) in Linux – Part II](https://www.tecmint.com/extend-and-reduce-lvms-in-linux/)
- [Lvextend command examples in Linux](https://www.thegeekdiary.com/lvextend-command-examples-in-linux/)

### Resize your disk
1. Use `gparted` and see if you can manualle extende the disk. If not, make a bootable USB with e.g. Ubuntu Desktop and boot it. Try gparted again.
2. If using LVM. I had a 10 GB virtual disk, but the root partition was smaller. Big mistake, so I had to adjust it:
````
df -h                                        #check the size e.g. mine is full: /dev/mapper/topsecret--vg-root  4.5G  4.3G   15M 100% /
lvextend --size 9GB /dev/topsecret-vg/root   #this extends it close to my max size
resize2fs /dev/mapper/topsecret--vg-root     #command to resize ext(2,3,4) file systems
df -h                                        #verify the newly added disk size
````
3. Messt commands i've used previous 
- Remember to boot the machine into recovery mode to eject the disk before working on it, or you'll be stuck trying to resize it!!
````powershell
resize2fs -p /dev/mapper/ubuntu--vg-ubuntu--lv           #Try this one first. If not working try next:
lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv  #Second try
lvextend --size 9GB /dev/topsecret-vg/root               #Third try. This one worked nov. 2024.

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

## Formating disks
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
lvscan                                     #get volumes, e.g. /dev/VG1/LV1
mount /dev/VG2/LV3 /mnt/123                #mount lvm on /mnt/123
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


## ZFS
````powershell
zpool import NAME

````
