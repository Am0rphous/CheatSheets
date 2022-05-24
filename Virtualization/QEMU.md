# Q E M U


Commands
````powershell
qemu-img create -f vpc tc.vhd 4G            Create Virtual Hard Drive

````

### Converting disks to other disk formats
````
qemu-img convert -O qcow2 vmware-disk.vmdk kvm-disk.qcow2           #converting to KVM compatible
````
