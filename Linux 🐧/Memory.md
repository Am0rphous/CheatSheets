# Memory

- Enable [Zram](https://fosspost.org/enable-zram-on-linux-better-system-performance/) - which is a Linux kernel module that creates compressed block devices in RAM, allowing for more efficient use of memory by storing swap data in a compressed format. This helps improve performance, especially on systems with limited RAM, by reducing the need for slower disk-based swap. [Configure zram ](https://github.com/iver0/configure-zram)
    ````shell
    swapon --show
    sudo swapoff  /swap                            #Deactivate it
    sudo swapoff /dev/sda2                         #Or deactivate the swap partition if its a disc
    #Disable swap in fstab:  sudo nano /etc/fstab
    sudo apt install zram-tools
    systemctl enable --now zramswap.service         #Enable after reboot and start it now
    ````
- Other
  - [alternatives are zswap and zcache](https://www.baeldung.com/linux/zram-zswap-zcache-comparison)
  - [utility zram-config ](https://github.com/ecdye/zram-config)
  - [nohang](https://github.com/hakavlad/nohang) - nohang package provides a highly configurable daemon for Linux which is able to correctly prevent out of memory (OOM) and keep system responsiveness in low memory conditions.

<br>

- [mem-app.sh](https://github.com/Am0rphous/Bash/blob/master/Memory/mem-app.sh) - Bash memory script
- [ps_memory.py](https://github.com/Am0rphous/Python/blob/main/Memory/ps_mem.py) - Python script to list applications and their ram usage
  ````shell
  cat /proc/meminfo       #shows memory info
  sudo dmidecode -t 17    #list Desktop Management Interface tabel for number 17
  free -h                 #human readable form
  free -b                 #bytes, k=kilobytes, m=megabytes =g=gigabytes
  vmstat
  ````


## Swap
- [SwapFaq Ubuntu Help](https://help.ubuntu.com/community/SwapFaq)
- Databases should use swapiness of 10 ish.
````shell
cat /proc/sys/vm/swappiness   #show swapiness. Default 60. Lower=use less swap.
sudo swapon --show            #display swap area
````
#### Change swapiness
- Temporary (lost on reboot) `sudo sysctl vm.swappiness=10`
- Permanent: `nano /etc/sysctl.conf` and add to the end of the file `vm.swappiness=10`
  - Then run `sudo sysctl --load=/etc/sysctl.conf`

<details> <summary>Create/ remove swap file</summary><br>
  
  #### To create it
  - [Hibernate and resume from a swap file (Ubuntu forum)](https://askubuntu.com/questions/6769/hibernate-and-resume-from-a-swap-file)
````shell
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
````shell
sudo swapoff -a -v                       #disable and be verbose
sudo rm /swapfile                        #removes the swapfile
sudo sed -i '/\/swapfile/d' /etc/fstab   #deletes the line "/swapfile" in fstab
````

</details>


