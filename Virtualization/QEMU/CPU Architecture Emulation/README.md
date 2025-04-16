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
