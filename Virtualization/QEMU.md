# Q E M U


Commands
````powershell
qemu-img create -f vpc tc.vhd 4G            Create Virtual Hard Drive

````

### Working with disks
````
qemu-img convert -O qcow2 vmware-disk.vmdk kvm-disk.qcow2                 #converting to KVM compatible
qemu-img convert -f raw -O qcow2 /tmp/source.raw /tmp/output.qcow2 -p     #converting raw to qcow2 with progressbar
qemu-img info source.qcow2            #get info about disk
````
