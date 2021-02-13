# Disk

## Creating Bootable USBs
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
