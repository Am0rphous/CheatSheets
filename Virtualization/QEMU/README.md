# QEMU (Quick Emulator)

- [Run osX in a Qemu/KVM VM](https://github.com/kholia/OSX-KVM)
- [Run different architectures in qemu in a docker container](https://github.com/multiarch/qemu-user-static)
- [How to: Use qemu-img command to convert between vmdk, raw, qcow2, vdi, vhd, vhdx formats/disk images (qemu-img create, snapshot, resize etc.)](https://dannyda.com/2020/06/25/how-to-use-qemu-img-command-to-convert-between-vmdk-raw-qcow2-vdi-vhd-vhdx-formats-disk-images-qemu-img-create-snapshot-resize-etc/)
- for later: https://github.com/hozan23/vms
- Virtio-Venus (Near-Native 3D acceleration) - https://wiki.cachyos.org/virtualization/virtio-venus/
  
<br>

```shell
qemu-img create -f vpc tc.vhd 4G            Create Virtual Hard Drive

qemu-system-x86_64 -m 64 -smp 1 -cdrom TinyCore-16.2.iso -boot d -enable-kvm

# https://ursrig.com/Qemu-Headless-Install
qemu-system-x86_64 -hda /dev/sdc1 -m 1G --enable-kvm -nographic -cdrom ebian.iso -boot d
#"Fire up qemu with the command above. Wait a few seconds, the screen will turn black after loading syslinux. Hit ESC, and enter:
# install fb=none vga=normal"
```

### Create a VM with existing disk
```shell
sudo qemu-system-x86_64 -enable-kvm -m 6144 -smp 8 -cpu host -machine q35 \
  -drive if=virtio,format=qcow2,file=./remnux.qcow2 \
  -netdev user,id=mylan,restrict=off \
  -device virtio-net-pci,netdev=mylan \
  -device virtio-gpu-pci \
  -nographic

-boot order=c \

sudo qemu-system-x86_64 \
  -enable-kvm \
  -m 6144 \
  -smp 8 \
  -cpu host \
  -machine q35 \
  -accel kvm \
  -drive if=virtio,format=qcow2,file="$DISK" \
  -boot order=c \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -nographic
```

### Working with disks
- [(PPT) QEMU Disk IO Which performs Better: Native or threads?](https://www.slideshare.net/slideshow/qemu-disk-io-which-performs-better-native-or-threads/62724391)
```shell
qemu-img info source.qcow2                                                # get info about disk
qemu-img convert -O qcow2 vmware-disk.vmdk  kvm-disk.qcow2                # 1. making it KVM compatible (qcow2 format)
qemu-img convert -f vmdk -O qcow2  kali2025.vmdk  kali.qcow2              # Another example
qemu-img convert -f raw  -O qcow2 /tmp/source.raw /tmp/output.qcow2 -p    # converting raw to qcow2 with progressbar


```

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
