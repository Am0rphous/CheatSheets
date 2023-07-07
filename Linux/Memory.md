# Memory

- [mem-app.sh](https://github.com/Am0rphous/Bash/blob/master/Memory/mem-app.sh) - Bash memory script
- [ps_memory.py](https://github.com/Am0rphous/Python/blob/main/Memory/ps_mem.py) - Python script to list applications and their ram usage

````
cat /proc/meminfo       #shows memory info
sudo dmidecode -t 17    #list Desktop Management Interface tabel for number 17
free -h                 #human readable form
free -b                 #bytes, k=kilobytes, m=megabytes =g=gigabytes
vmstat
````


## Swap
- [SwapFaq Ubuntu Help](https://help.ubuntu.com/community/SwapFaq)
- Databases should use swapiness of 10 ish.
````powershell
cat /proc/sys/vm/swappiness   #show swapiness. Default 60. Lower=use less swap.
sudo swapon --show            #display swap area
````
#### Change swapiness
- Temporary (lost on reboot) `sudo sysctl vm.swappiness=10`
- Permanent: `nano /etc/sysctl.conf` and add to the end of the file `vm.swappiness=10`
  - Then run `sudo sysctl --load=/etc/sysctl.conf`

#### Create a swap file
````powershell
sudo fallocate -l 1G /swapfile   #creates 1 GB swapfile
sudo chown root:root /swapfile   #change owner if not running as root already
sudo chmod 600 /swapfile         #make it readable only for root
sudo mkswap /swapfile            #sets up swap area
sudo swapon /swapfile            #enable swap on this file
sudo findmnt -no UUID -T /swapfile\n              #find UUID
sudo nano /etc/initramfs-tools/conf.d/resume      #add "RESUME=UUID=bla-bla-uid"

````
- Add to /etc/fstab `/swapfile    none    swap    sw    0   0`
- Or use the UUID in /etc/fstab `UUID=blabla-uid-here  none swap sw 0 0`
- Might need to add `resume=UUID=blabla-uid-here` into `/etc/default/grub` in `GRUB_CMDLINE_LINUX_DEFAULT` and run `sudo update-grub`


#### Disable and remove a swap file
````
sudo swapoff -a -v                       #disable and be verbose
sudo rm /swapfile                        #removes the swapfile
sudo sed -i '/\/swapfile/d' /etc/fstab   #deletes the line "/swapfile" in fstab
````

