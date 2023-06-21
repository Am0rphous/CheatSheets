# D r i v e r s 

To show t

````powershell
lsmod                               # display modules in the Linux Kernel. 
rmmod                               # unload module
modprobe                            # load it
modprobe 88XXau                     # loads the 88XXau driver
modinfo {driver-name}
awk '{ print $1 }' /proc/modules
ls /proc/modules                               # shows what kernel modules (drivers) are currently loaded into memory
readlink /sys/class/net/wlan0/device/driver    # shows wlan0 driver
readlink /sys/class/net/wlan1/device/driver    # shows wlan1 driver
````
