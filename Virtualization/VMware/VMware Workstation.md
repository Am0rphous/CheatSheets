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
vmware workstation debian stuck on auth polkit
#https://community.broadcom.com/vmware-cloud-foundation/communities/community-home/digestviewer/viewthread?GroupId=7171&MessageKey=a5e7ef9c-b0f8-41e9-875e-0e5ef0eafe41&CommunityKey=fb707ac3-9412-4fad-b7af-018f5da56d9f

/usr/lib/vmware/bin/vmware-setup-helper -e -o -c no


sudo vmware-modconfig --console --install-all
[AppLoader] GLib does not have GSettings support.
Stopping VMware services:
   VMware Authentication Daemon                                        done
   Virtual machine monitor                                             done
Starting VMware services:
   Virtual machine monitor                                             done
   Virtual machine communication interface                             done
   VM communication interface socket family                            done
   Virtual ethernet                                                    done
   VMware Authentication Daemon                                        done
   Shared Memory Available                                             done
    
````
