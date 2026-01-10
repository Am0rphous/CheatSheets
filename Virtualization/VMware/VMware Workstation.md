# VMware Workstation

- [Download Workstation for Linux](https://www.vmware.com/go/getworkstation-linux)
  - [Patches needed to build VMware (Player and Workstation) host modules against recent kernels ](https://github.com/mkubecek/vmware-host-modules)
  - [linux-vmware-host-modules-builder-cli](https://github.com/LinuxEuphony/vmware-host-modules-builder-cli)  This shell script downloads, builds and installs Vmware host modules for your Linux Vmware. 

### Enable [promiscuous mode on Linux](https://kb.vmware.com/s/article/287) VMs
1. Lets add a group for e.g. malware analysis <br>
`sudo groupadd malware-analysis`
2. Change group ownership on the vmnet0 device <br> 
`chgrp malware-analysis /dev/vmnet0`
3. Fix appropriate permissions  <br> 
`chmod g+rw /dev/vmnet0`  <br>
`chmod a+rw /dev/vmnet0` Fixing for all users

## note error 2026
````shell
/usr/lib/vmware/bin/vmware-setup-helper -e -o -c no
````
