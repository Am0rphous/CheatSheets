# VMware ESXi

- [General ESXi Security Recommendations](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-B39474AF-6778-499A-B8AB-E973BE6D4899.html)
- [VMware ESXi](https://www.vmware.com/products/esxi-and-esx.html)


### Manual updating VIBs from an ESXi host
- for later:  https://tinkertry.com/easy-update-to-latest-esxi
````powersell
esxcli software vib install -d “/vmfs/volumes/Datastore/DirectoryName/PatchName.zip“
esxcli software vib update -d “/vmfs/volumes/Datastore/DirectoryName/PatchName.zip”
````

### Practical commands
````powersell
esxcli network ip connection list
esxcli network ip connection list | grep -i listen
esxcli network ip connection list | grep 3260
esxcli network ip neighbor list
esxcli network vm list
vmkping -S vmotion IP
vmkping -I vmk1 S vmotion IP
````
##### VMs
````
vim-cmd vmsvc/getallvms
````

#### Networking
- Disable IPV6
````
esxcli network ip set --ipv6-enabled=false
reboot
````
