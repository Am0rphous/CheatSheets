# D r i v e r s 

To show t

````powershell
lsmod                                 # display modules in the Linux Kernel. 
rmmod                                 # unload module
modprobe                              # load it
modinfo {driver-name}
awk '{ print $1 }' /proc/modules
ls /proc/modules                      # shows what kernel modules (drivers) are currently loaded into memory
````
