# VMware

## ESXI
### Update BIOS
- [IDRAC8](https://www.dell.com/community/PowerEdge-Hardware-General/RAC0613-The-uploaded-file-is-invalid-iDRAC-update-issue/td-p/7788739)

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
#### Networking
- Disable IPV6
````
esxcli network ip set --ipv6-enabled=false
reboot
````



### Video Memory
- [Note:](https://kb.vmware.com/s/article/1031002) Video Memory (VRAM) does not affect RDP sessions and the above steps are only applicable for connections through PCOIP.
- [Configure 3D Graphics and Video Cards](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-E03ED27D-E469-4115-80E1-435125D6168B.html)

### VMware Remote Console
- Uninstall with
````
vmware-installer -l                 #Verify installation
vmware-installer -u vmware-vmrc     #Remove VMRC
````
