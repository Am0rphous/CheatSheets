# VMware Workstation

### Enable [promiscuous mode on Linux](https://kb.vmware.com/s/article/287) VMs
1. Lets add a group for e.g. malware analysis <br>
`sudo groupadd malware-analysis`
2. Change group ownership on the vmnet0 device <br> 
`chgrp malware-analysis /dev/vmnet0`
3. Fix appropriate permissions  <br> 
`chmod g+rw /dev/vmnet0`  <br>
`chmod a+rw /dev/vmnet0` Fixing for all users
