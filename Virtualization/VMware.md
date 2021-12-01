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
