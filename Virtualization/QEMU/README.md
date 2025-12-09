# Q E M U (Quick Emulator)

- [Run osX in a Qemu/KVM VM](https://github.com/kholia/OSX-KVM)
- [Run different architectures in qemu in a docker container](https://github.com/multiarch/qemu-user-static)
- [How to: Use qemu-img command to convert between vmdk, raw, qcow2, vdi, vhd, vhdx formats/disk images (qemu-img create, snapshot, resize etc.)](https://dannyda.com/2020/06/25/how-to-use-qemu-img-command-to-convert-between-vmdk-raw-qcow2-vdi-vhd-vhdx-formats-disk-images-qemu-img-create-snapshot-resize-etc/)

- for later: https://github.com/hozan23/vms
Commands
````shell
qemu-img create -f vpc tc.vhd 4G            Create Virtual Hard Drive

qemu-system-x86_64 -m 64 -smp 1 -cdrom TinyCore-16.2.iso -boot d -enable-kvm

# https://ursrig.com/Qemu-Headless-Install
qemu-system-x86_64 -hda /dev/sdc1 -m 1G --enable-kvm -nographic -cdrom ebian.iso -boot d
#"Fire up qemu with the command above. Wait a few seconds, the screen will turn black after loading syslinux. Hit ESC, and enter:
# install fb=none vga=normal"
````

### Working with disks
- [(PPT) QEMU Disk IO Which performs Better: Native or threads?](https://www.slideshare.net/slideshow/qemu-disk-io-which-performs-better-native-or-threads/62724391)
````shell
qemu-img convert -O qcow2 vmware-disk.vmdk kvm-disk.qcow2                 #converting to KVM compatible
qemu-img convert -f raw -O qcow2 /tmp/source.raw /tmp/output.qcow2 -p     #converting raw to qcow2 with progressbar
qemu-img info source.qcow2            #get info about disk
````

### Qemu on macOS
- [QEMU to create a Ubuntu 20.04 Desktop VM on macOS](https://www.arthurkoziel.com/qemu-ubuntu-20-04/)
- Install Libvirt - [https://libvirt.org/macos.html](https://libvirt.org/macos.html)
  ````shell
  brew install libvirt
  libvirtd                      #start manually
  brew services start libvirt   #on system boot
  ````
- Install Virt Manager
  ````shell
  #https://www.arthurkoziel.com/running-virt-manager-and-libvirt-on-macos/
  brew install virt-manager virt-viewer  
  ````
