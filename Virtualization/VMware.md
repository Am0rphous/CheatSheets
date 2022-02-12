# VMware

### Manual updating VIBs from an ESXi host
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
````

### Video Memory
- [Note:](https://kb.vmware.com/s/article/1031002) Video Memory (VRAM) does not affect RDP sessions and the above steps are only applicable for connections through PCOIP.
- [Configure 3D Graphics and Video Cards](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-E03ED27D-E469-4115-80E1-435125D6168B.html)

