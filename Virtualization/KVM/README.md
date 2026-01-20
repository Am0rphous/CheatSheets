# Kernel-based Virtual Machine
- _"KVM is compiled from about 10,000 lines of well-optimized code, thereby maximizing performance. KVM is primarily an open-source hypervisor and is distributed for free without the need to pay for a license. Supports Nested virtualization.Open vSwitch (OVS) is the open-source implementation of a virtual switch that can be used with KVM. KVM supports VM live migration between KVM hosts. Basic methods to back up KVM VMs are using virsh, which is the command line Linux tool for KVM. When using virsh, the VM must be powered off. You can use commands and scripts to back up running VMs and automate the backup process using Cron."_
- "KVM. Security-enhanced Linux (SELinux) and secure virtualization (sVirt) are available for Red Hat KVM distributions. A combination of these features is used to detect and prevent threats, and ensure VM security and isolation. Oracle KVM is released with Ksplice. KVM hypervisor security features include:
  - Mandatory Access Control security between VMs
   - iptables (the firewall for Linux) configuration for improved security
   - UEFI Secure Boot for Windows guests available after manual configuration
   - VM data protection with Total Memory Encryption (TME) and Multi-Key Total Memory Encryption (MKTME)
- [source](https://www.nakivo.com/blog/kvm-vs-vmware-performance-pricing-and-hardware-requirements/)

Links for later
````
https://www.lzone.de/cheat-sheet/KVM
https://gist.github.com/mbodo/f0c1432a52cc62737cb6084e043ef3e0
https://fazlerabbi37.github.io/blogs/kvm_cheat_sheet.html
https://adhioutlined.github.io/virtual/KVM-or-virsh-Cheat-Sheet/
https://www.cyberciti.biz/faq/how-to-rename-kvm-virtual-machine-vm-domain-with-virsh-command/
https://blog.programster.org/kvm-cheatsheet
https://bobcares.com/blog/manage-kvm-guest-virtual-machines-using-virsh-commands/
How to Easily Backup KVM Virtual Machine in 4 Ways?
````
- [kvm/kvm.git](https://git.kernel.org/pub/scm/virt/kvm/kvm.git) - Development repo.
- [linux-kvm.org](https://www.linux-kvm.org/page/Main_Page)
- [KVM](https://www.kernel.org/doc/html/latest/virt/kvm/index.html) - [What is KVM?](https://www.redhat.com/en/topics/virtualization/what-is-KVM)
  - [KVM Networking Docs](https://wiki.libvirt.org/page/Networking#NAT_forwarding_.28aka_.22virtual_networks.22.29)
  - [KVM/QEMU Windows guest drivers (virtio-win)](https://github.com/virtio-win/kvm-guest-drivers-windows) - Windows paravirtualized.
  - [KVM Virtualization in RHEL 7 Made Easy.pdf](https://linux.dell.com/files/whitepapers/KVM_Virtualization_in_RHEL_7_Made_Easy.pdf)
  - [KVM-Virtualization with Rocky Linux](https://github.com/tomwechsler/KVM-Virtualization-with-Rocky-Linux) - Everything about KVM-Virtualization with Rocky Linux 
  - [Libvirt - Hooks for specific system management](https://www.libvirt.org/hooks.html)
- [MemFlow](https://github.com/memflow/memflow) - physical memory introspection framework [memflow.github.io](https://memflow.github.io).
  - [Memflow-cli](https://github.com/memflow/memflow-cli) - Memflow command line interface.
  - [Memflow-kvm](https://github.com/memflow/memflow-kvm) - Linux kernel module for memflow's KVM connector.
  - [Memflow-qemu-procfs](https://github.com/memflow/memflow-qemu-procfs) - memflow connector backend to interface with qemu through the process filesystem.
- [Oracle's KVM Usage](https://docs.oracle.com/en/operating-systems/oracle-linux/kvm-user/kvm-KVMUsage.html#basic-usage)
- [planet.virt-tools.org](https://planet.virt-tools.org/) - News from QEMU, KVM, libvirt, libguestfs, virt-manager and related tools.

## Management
- https://itsfoss.gitlab.io/post/manage-kvm-virtual-machines-using-cockpit-web-console/
- https://itsfoss.gitlab.io/post/manage-kvm-virtual-machines-with-virsh-program/

- scripts
  - https://github.com/doccaz/kvm-scripts
  - 
## Setup
- [KaliLinux 2017.1: Install KVM for virtualization](https://www.hiroom2.com/2017/07/23/kalilinux-2017-1-kvm-en/)
Installation with `sudo`
  ````shell
  apt install qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager kvmtool
  service libvirtd start
  usermod -aG libvirt $USER
  usermod -aG kvm $USER
  virsh net-start default        #Start network "default"
  virsh net-autostart default    #Autostarts the nat network
  reboot                         #Ensures group membership are applied
  ````
  - Auto login on Kali using LightDM: edit `/etc/lightdm/lightdm.conf`
    ````shell
    [Seat:*]   #Find this section and add below:
    autologin-user=kali
    autologin-user-timeout=0 
    ````
  - [gdm3](https://linuxconfig.org/how-to-enable-autologin-on-kali-linux)

### Integration and console
- Standard. `spice-vdagent` enables copy/paste between host and vm.
  - Linux:
    ````shell
    sudo apt install spice-vdagent
    systemctl enable --now spice-vdagent
    sudo apt install qemu-guest-agent
    systemctl enable --now spice-vdagent
    ````
  - Windows: Download [spice-guest-tools](https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe) and virtio-win-guest-tools from [Virtio-Win ISO](https://github.com/virtio-win/kvm-guest-drivers-windows)
- Dynamic screen sizing: Add "Video model" to **VGA** caus the others not functioning right (sept 2025). In addition, ensure "Resize guest with window" is "on". Open virt-manager -> Edit -> Preferences -> Console -> and enable it
  - Using VGA will fuck up Chrome/Chromium. Its unresponsive and takes forever to load. Use Firefox
- Consider install zram to compress memory within the VM and increase performance. Check [cheatsheets](https://github.com/Am0rphous/CheatSheets/blob/main/Linux%20%F0%9F%90%A7/Memory.md)
````shell
#In VM
sudo apt update && sudo apt install -y linux-image-$(uname -r) linux-headers-$(uname -r) qemu-guest-agent spice-vdagent #virtio-utils
systemctl enable --now qemu-guest-agent

#For remote display. Change "Video" to "virtio" or "QXL"
apt install virt-viewer
remote-viewer spice://localhost:5900
````
- Create a shared folder linux. [inspo](https://discussion.fedoraproject.org/t/kvm-host-guest-shared-folder-with-virtiofs-linux-only-guests/150485)
  ````shell
  ##On main host run:
  sudo apt install virtiofs
  mkdir ~/kvmshare
  sudo chown -R $USER:libvirt-qemu ~/kvmshare
  
  ##In KVM enable "Shared memory" for the VM.
  ##add 'hardware' and "Filesystem" with these settings
  #Source: /home/$USER/kvmshare/    #On the host
  #Target: share                    #Whatever
  
  #Start VM and run
  sudo mkdir /mnt/shared/ && sudo mount -t virtiofs shared /mnt
  
  #Add persistence as ROOT
  echo "shared   /mnt/shared   virtiofs   defaults,_netdev   0 0" >> /etc/fstab
  ````
- **Create a shared folder on Windows guest** - [read more](https://imanudin.net/2025/05/05/how-to-access-host-folder-in-windows-vm-on-proxmox-using-virtiofs/)
  - Add hardware -> Filesystem -> Driver:virtiofs Source path:/etc/my/shared Target path:whateverNameHere
  - Start VM and install this **within** [WinFsp](https://github.com/winfsp/winfsp/releases) and [virtiofs driver](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso)
  - Open `Services` and enable autostart+start `VirtIO-FS Service`
- VM when using `cockpit`
  ````shell
  sudo apt install qemu-guest-agent             #Within VM. Improves performance, integration and management.
  sudo apt install spice-vdagent                #Within VM. Enhances interaction between guest and host - only if you use SPICE
  systemctl enable serial-getty@ttyS0.service   #make it autostart
  systemctl restart serial-getty@ttyS0.service  #restart the service
  virsh console ubuntu1                         #enter console for vm 'ubuntu1'
  ctr+5                                         #to console
  ````

## Usage
- [Managing Virtual Core & vCPU in KVM](https://bobcares.com/blog/selecting-the-number-of-vcpus-and-cores-for-a-virtual-machine/)

````shell
sudo service qemu-kvm status && sudo service libvirtd status

virsh list --all
virsh shutdown vmName                 poweroff vm |
virsh shutdown vm-dev01               poweroff vm-dev01
virsh domrename vm01-clone1 vm01      rename vm01-clone to vm01
virsh blockresize rhel8 /var/lib/libvirt/images/rhel8.qcow2 40G      #extend disk with 40 GB
kvm_stat                              Displays KVM statistics
sudo virt-install --name=deepin-vm --os-variant=Debian10 --vcpu=2 --ram=2048 --graphics spice --location=/home/Downloads/deepin-20Beta-desktop-amd64.iso --network bridge:vibr0 
virt-top                                       #sudo apt install virt-top: https://linux.die.net/man/1/virt-top
virsh edit myvm                                #edit the xml file for myvm
sudo nano /etc/libvirt/qemu/myvm.xml           #manually
sudo virsh define /etc/libvirt/qemu/myvm.xml   #validate file
xmllint --format /etc/libvirt/qemu/myvm.xml    #verify correct format in the xml file
````

## Saving state
- right click on vm in `virt-manager` -> shutdown -> save
- location `/var/lib/libvirt/qemu/save`

## Disks
- [Convert disk images to various formats using qemu-img](https://techpiezo.com/linux/convert-disk-images-to-various-formats-using-qemu-img/)
- Kali Linux is based on [Debian Testing](https://www.kali.org/docs/policy/kali-linux-relationship-with-debian/#forked-packages). Choose that profile when importing disk in KVM
- Remnux is based on [Ubuntu 22.04](https://docs.remnux.org/install-distro/install-from-scratch)
````shell
#Convert a Virtualbox Remnux VM to KVM/QCOW2 format
tar xvf remnux-v7-focal.ova                #Extract the ova
gunzip remnux-v7-focal-disk1.vmdk.gz       #Extract the gz
qemu-img convert -f vmdk remnux-v7-focal-disk1.vmdk -O qcow2 remnux.qcow2    #Convert the vmdk to qcow2

qemu-img info output.qcow2
qemu-img convert -f raw -O qcow2 image.img image.qcow2

sudo qemu-img resize /var/lib/libvirt/images/rhel8.qcow2 +10G           #increase disk
sudo qemu-img resize /var/lib/libvirt/images/rhel8.qcow2 -5G --shrink   #shrink disk
````
- **To resize a windows disk**
  1. Within the VM: Download [sdelete](https://learn.microsoft.com/en-us/sysinternals/downloads/sdelete) and nullify disk with `sdelete.exe -z c:`
  2. Shutdown VM and run `qemu-img convert -O qcow2 -c windows.qcow2 windows-new.qcow2`
  3. On KVM host, run `qemu-img resize windows.qcow2 -64G --shrink` to shrink the virtual size (from e.g. 128 GB down to 64 GB virtual size)
  4. Rename the disk so the VM can be restarted with "new" thinprovisioned disk `mv windows-new.qcow2 windows.qcow2`
  5. Start VM and tadaa a disk using very little storage
  
- **To reduce a Linux disk** (when qcow2 is using e.g. 110gb storage and you want it thin provisioned down to e.g. 5,8 GB (internal use))
  1. Shutdown vm and clone/make a backup of qcow2 disk `cp linux.qcow2 linux.qcow2.bak`
  2. Turn on vm and run
     ````shell
     sudo dd if=/dev/zero of=/zerofill.tmp bs=1M status=progress || true     #until No space left on device
     sudo sync
     sudo rm -f /zerofill.tmp
     sudo sync
     shutdown now
     ```` 
  3. On the host compress old disk to a new disk with
    ````shell
    qemu-img convert -O qcow2 -c linux.qcow2 linux-new.qcow2
    cp linux-new.qcow2  linux-new.bak           #Create a backup of the clean and newly compressed disk
    ````
  4. Rename disk `mv linux-new.qcow2 linux.qcow2` and start VM.


## GPU Passthrough
1. Enable IOMMU / VT-d (Intel) or AMD-Vi (AMD) in the BIOS. Search your motherboard and check if it's available. Update your BIOS to newest version btw!
2. Enable IOMMU in Grub:
````
sudo nano /etc/default/grub

## add
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_iommu=on iommu=pt"

## update
sudo update-grub
```` 
3. Check if IOMMU is enabled and working `sudo dmesg | grep -e DMAR -e IOMMU`
4. Add your GPU's PCI ID to `/etc/modprobe.d/vfio.conf`
````shell
lspci -k | grep NVIDIA

## output
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU104 [GeForce RTX 3080 Ti] [10de:2204] (rev a1)
01:00.1 Audio device [0403]: NVIDIA Corporation TU104 HD Audio Controller [10de:1aef] (rev a1)

sudo nano /etc/modprobe.d/vfio.conf
options vfio-pci ids=10de:2204,10de:1aef
softdep nvidia pre: vfio-pci

## then
sudo update-initramfs -u
````
4. In Virt-manager add the sound controller to the GPU and the GPU itself to the VM.
5. When rebooting the screen will be black after virtualizing the GPU. Keep the cabel in the GPU but log in through another machine and start the VM with `sudo virsh start myW10` and the graphics should show on your screen. Tadaa
6. Debug:
````
sudo service libvirtd status
sudo journalctl -u libvirtd -f
sudo lsof /dev/nvidia*
sudo fuser -v /dev/nvidia*      #what ar eusing nvidia. I had Ollama running and using the GPU
dmesg | grep -e DMAR -e IOMMU
sudo dmesg | grep vfio
sudo dmesg | grep iommu
find /sys/kernel/iommu_groups/ -type l
readlink /sys/bus/pci/devices/0000:01:00.0/iommu_group
````

### Virtualize CPU
- Run `cat /proc/cpuinfo` and if you have e.g. 12 logical host CPU's then your VM config should look like this:
1. Enable "Copy host CPU configuration".
2. Enable "Manually set CPU topology" to match your host CPU.
````
Sockets:  1
Cores:    6
Threads:  2
````
- Testing with Geekbench: Single-Core Score 1283. Multi-Core score: 5575
- Changing to 12 cores with 1 thread gave: Single-Core Score 1292. Multi-Core score: **4412**

### Virtualize devices (peripherals, usb, mouse, keyboard, bluetooth)
Add peripherals through [Cockpit](https://cockpit-project.org/) from another computer. Mouse and keyboard will be added and installed automatically when detected by e.g. windows.

### Windows 10 VM tips
- Check out
  - qemu-guest-agent
  - windows VirtIO Drivers (virtio-win-guest-tools.exe) [link](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.266-1/)
  - Spice agent for windows (spice-guest-tools - https://www.spice-space.org/download.html
  - `UsbDk` eg UsbDk_1.0.22_x64.msi and `usbredirect` eg usbredirect-x64-0.14.0.msi- [link](https://www.spice-space.org/download.html)
    

### Automate things
1. Lets create a script that checks if you choose to enable iommu at boot. Create the file `usr/local/bin/passthrough-mode.sh` with the content:
````shell
#!/bin/bash

if grep -q "intel_iommu=on" /proc/cmdline; then

    # Aktiver VFIO og passthrough
    echo "Lets configure gaming mode.."
    #https://www.cyberciti.biz/faq/display-view-linux-kernel-parameters-for-booted/
    echo "Detected parameter 'iommu=on'"

    echo "Starting to update /etc/modprobe.d/vfio.conf with correct config.."
    echo "options vfio-pci ids=10de:2208,10de:1aef" > /etc/modprobe.d/vfio.conf
    echo "softdep nvidia pre: vfio-pci" >> /etc/modprobe.d/vfio.conf
    echo "Done with /etc/modprobe.d/vfio.conf..."

    echo "Starting to update initramfs.."
    update-initramfs -u
    echo "Done updating initramfs..."

    sleep 5
    echo "Trying to start virtual machine 'w10' in KVM.."
    virsh start w10
    echo "Done.."
    echo "Gaming mode should be ready.."
else
    echo "Didnt detect 'iommu=on' for the current session."
    echo "Continue to configure work mode.."
    # Deaktiver VFIO og bruk GPU til host
    echo "Adding hashtags to config /etc/modprobe.d/vfio.conf.."
    echo "#options vfio-pci ids=10de:2208,10de:1aef" > /etc/modprobe.d/vfio.conf
    echo "#softdep nvidia pre: vfio-pci" >> /etc/modprobe.d/vfio.conf
    echo "Done.."

    echo "Starting to update initramfs.."
    update-initramfs -u
    echo "Done updating initramfs..."
    echo "Work mode ready.."
fi
````
2. Make it executable with `chmod +x /usr/local/bin/passthrough-mode.sh`
3. Create a service file `/etc/systemd/system/passthrough.service` with:
````shell
[Unit]
Description=Setup GPU Passthrough
After=cryptsetup.target
Requires=cryptsetup.target

[Service]
ExecStart=/usr/local/bin/passthrough-mode.sh
Type=oneshot

[Install]
WantedBy=multi-user.target
````
4. Make the service executable with `chmod +x /etc/systemd/system/passthrough.service`
5. Reload daemon `sudo systemctl daemon-reload`
6. Enable the new service `systemctl enable passthrough.service`
7. Make a custom entry in the grub boot menu. Create the file e.g. `/etc/grub.d/40_custom` with the content looking like
````shell
#!/bin/sh
exec tail -n +3 $0

menuentry 'Normal - Work Mode' {
  load_video
  insmod gzio
  if [ x$grub_platform = xxen ]; then insmod xzio; insmod lzopio; fi
  insmod part_gpt
  insmod ext2
  search --no-floppy --fs-uuid --set=root 9565f7fd-33a3-49f7-b394-64cbea1d90d0
  echo "Laster inn Linux-kjerna.."
  linux /vmlinuz-6.6.9-amd64 root=/dev/mapper/carbon--vg-root ro splash intel_iommu=off nomodeset

  echo "Laster inn initrd.."
  initrd /initrd.img-6.6.9-amd64
}

menuentry 'GPU Passthrough - Gaming Mode' {
  load_video
  insmod gzio
  if [ x$grub_platform = xxen ]; then insmod xzio; insmod lzopio; fi
  insmod part_gpt
  insmod ext2
  search --no-floppy --fs-uuid --set=root 9565f7fd-33a3-49f7-b394-64cbea1d90d0

  echo "Laster inn Linux-kjerna.."
  linux /vmlinuz-6.6.9-amd64 root=/dev/mapper/carbon--vg-root ro splash intel_iommu=on iommu=pt nomodeset

  echo "Laster inn initrd.."
  initrd /initrd.img-6.6.9-amd64
}
````
7. Ensure the file is executable `chmod +x /etc/grub.d/40_custom`
8. Run `update-grub && update-initramfs -u`
