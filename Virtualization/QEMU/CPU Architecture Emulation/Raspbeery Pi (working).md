# Emulate Raspberri PI (ARM) on Linux (intel/amd64 bit arch)

- [Old Raspbian Images](https://downloads.raspberrypi.org/raspbian/images/)
- [Rpi kernels](https://github.com/dhruvvyas90/qemu-rpi-kernel)
````
sudo apt-get install qemu-system-arm

#Download the rspi image
wget https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-07-05/2017-07-05-raspbian-jessie.zip
unzip 2017-07-05-raspbian-jessie.zip  

#To emulate do
qemu-system-arm -kernel kernel-qemu-4.4.34-jessie \
-cpu arm1176 \
-m 256 \
-M versatilepb \
-no-reboot \
-serial stdio \
-append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
-drive file=2017-07-05-raspbian-jessie.img,format=raw
````

## Convert Qemu VM to Virtualbox
- [inspo](https://jiangsc.me/2019/05/28/Converting-QEMU-VM-to-VirtualBox-VM/)
````
qemu-img convert 2017-07-05-raspbian-jessie.img -O raw rspi.raw
vboxmanage convertfromraw rspi.raw --format vdi rspi.vdi
vboxmanage modifyhd rspi.vdi --compact

````
