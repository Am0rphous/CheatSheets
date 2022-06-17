# VMware Workstation

### Enable [promiscuous mode on Linux](https://kb.vmware.com/s/article/287) VMs
1. Lets add a group for e.g. malware analysis <br>
`sudo groupadd malware-analysis`
2. Change group ownership on the vmnet0 device <br>
`chgrp malware-analysis /dev/vmnet0`
3. Fix appropriate permissions `chmod g+rw /dev/vmnet0` 
  - Fix for all users: `chmod a+rw /dev/vmnet0`
