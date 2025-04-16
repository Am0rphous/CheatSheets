# Q E M U

- [Run different architectures in qemu in a docker container](https://github.com/multiarch/qemu-user-static)
- [How to: Use qemu-img command to convert between vmdk, raw, qcow2, vdi, vhd, vhdx formats/disk images (qemu-img create, snapshot, resize etc.)](https://dannyda.com/2020/06/25/how-to-use-qemu-img-command-to-convert-between-vmdk-raw-qcow2-vdi-vhd-vhdx-formats-disk-images-qemu-img-create-snapshot-resize-etc/)

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
