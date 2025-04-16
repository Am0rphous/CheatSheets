# CPU Architecture Emulation


````
qemu-system-aarch64 -cpu help 
Available CPUs:
  arm1026
  arm1136
  arm1136-r2
  arm946
  cortex-a55
  cortex-a57
  cortex-a7
(...)
````

## Debian ARM
- [Installing Debian on QEMU’s 64-bit ARM “virt” board - 2017](https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-board/) - nope
- [Installing Debian on QEMU’s 32-bit ARM “virt” board - 2016](https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-qemus-32-bit-arm-virt-board/)
## Ubuntu ARM
- [ARMonQEMUforDebianUbuntu.md](https://gist.github.com/luk6xff/9f8d2520530a823944355e59343eadc1) - nope
- [Can't boot Ubuntu Server 22.04 LTS ARM 64-bit ISO under QEMU on Windows 11](https://superuser.com/questions/1747723/cant-boot-ubuntu-server-22-04-lts-arm-64-bit-iso-under-qemu-on-windows-11) - didnt get it to work
````
qemu-system-aarch64 -M virt -cpu cortex-a72 -nographic \
    -net nic -net user \
    -bios QEMU_EFI.fd -hda ubuntu-arm.img
````
- [Emulating ARM on QEMU, with UEFI](https://kya8.github.io/p/emulating-arm-on-qemu-with-uefi/) - didnt get it to work
  - [AAVMF_VARS.fd and AAVMF_CODE.fd](https://github.com/BaoqianWang/VirtualizationOnJetsonTX2)

### messy shit
````
#http://cdimage.ubuntu.com/releases/24.04/release/
wget cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04.2-netboot-arm64.tar.gz
tar -xvf ubuntu-24.04.2-netboot-arm64.tar.gz 

qemu-img create -f qcow2 u2-arm.qcow2 15G
	
qemu-system-aarch64 -M virt -m 4096 -cpu cortex-a53 -smp 4 \
  -kernel linux \
  -initrd initrd \
  -drive if=none,file=u-arm.qcow2,format=qcow2,id=hd \
  -device virtio-blk-pci,drive=hd \
  -netdev user,id=mynet \
  -device virtio-net-pci,netdev=mynet \
  -nographic -no-reboot

qemu-system-aarch64 -M virt -m 4096 -cpu cortex-a53 \
-kernel linux \
-initrd initrd \
-drive if=none,file=u2-arm.qcow2,format=qcow2,id=hd \
-device virtio-blk-pci,drive=hd \
-netdev user,id=mynet \
-device virtio-net-pci,netdev=mynet \
-nographic -no-reboot \
-append "netboot=yes url=http://10.0.2.1/Downloads/ubuntu-24.04.2-live-server-arm64.iso"

Internet: https://cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04.2-live-server-arm64.iso
Local: http://10.0.2.1:8000/Downloads/ubuntu-24.04.2-live-server-arm64.iso

 -m 4G -cpu cortex-a53 -smp 2 \   
-enable-kvm \ 
-net nic -net user \ 
-drive format=raw,file=${HOME}/Downloads/ubuntu-24.04.2-preinstalled-desktop-arm64+raspi.img,index=0,if=virtio \   
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.fd \ 
-drive file=${HOME}/Downloads/ubuntu-24.04.2-live-server-arm64.iso,index=2,media=cdrom,readonly

qemu-system-aarch64 -M virt -m 4096 -cpu cortex-a72 -nographic \
    -machine virt -smp 4 \
    -net nic -net user \
    -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
    -hda raspi.img
    -drive file=ubuntu-22.04.2-live-server-arm64.iso,if=none,id=cdrom,cache=writeback \
    -device virtio-blk,drive=cdrom,bootindex=0 \

qemu-system-aarch64 -cpu cortex-a15 -m 4096 \
 -machine virt -drive if=virtio,format=raw,file=ubuntu-24.04.2-live-server-arm64.iso -boot d

ORIGINAL
qemu-system-arm -M virt -m 4096M -cpu cortex-a72 -smp 4 \
-device qemu-xhci -device usb-kbd \
-blockdev qcow2,node-name=root,file.driver=file,file.filename=u2-arm.qcow2 -device virtio-blk-device,drive=root \
-nic user,model=virtio \
-pflash ./AAVMF32_CODE.fd -pflash ./AAVMF32_VARS.fd \
-device VGA
-virtfs local,path=/host/path/to/shared/,id=share,mount_tag=share,security_model=mapped

mine 
qemu-system-aarch64 -M virt -m 4096M -cpu cortex-a72 -smp 4 \
 -device qemu-xhci -device usb-kbd \
 -blockdev qcow2,node-name=root,file.driver=file,file.filename=u2-arm.qcow2 -device virtio-blk-device,drive=root \
 -nic user,model=virtio \
 -pflash ./AAVMF_CODE.fd -pflash ./AAVMF_VARS.fd \
 -device virtio-blk-pci,drive=hd \
 -netdev user,id=mynet \
 -device virtio-net-pci,netdev=mynet \
 -nographic -no-reboot 
````
