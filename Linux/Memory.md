# Memory

````
cat /proc/meminfo
sudo dmidecode -t 17
free -h                 #human readable form
free -b                 #bytes, k=kilobytes, m=megabytes =g=gigabytes
vmstat
````

### Script
- [mem-app.sh](https://github.com/Am0rphous/Bash/blob/master/Memory/mem-app.sh) - Bash script
- [ps_memory.py](https://github.com/Am0rphous/Python/blob/main/Memory/ps_mem.py) - Python script to list applications and their ram usage

### Swap
- Check swappiness `cat /proc/sys/vm/swappiness`
- Useful commands
````powershell
sudo swapon --show
````
#### Change swapiness
- This is lost on reboot `sudo sysctl vm.swappiness=10`
- Permanent: `nano /etc/sysctl.conf` and add to the end of the file `vm.swappiness=10`
  - Then run `sudo sysctl --load=/etc/sysctl.conf`
#### Create a swap file
````powershell
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
````
- Add to /etc/fstab `/swapfile swap swap defaults 0 0`
