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
  - [Libvirt - Hooks for specific system management](https://www.libvirt.org/hooks.html)
- [MemFlow](https://github.com/memflow/memflow) - physical memory introspection framework [memflow.github.io](https://memflow.github.io).
  - [Memflow-cli](https://github.com/memflow/memflow-cli) - Memflow command line interface.
  - [Memflow-kvm](https://github.com/memflow/memflow-kvm) - Linux kernel module for memflow's KVM connector.
  - [Memflow-qemu-procfs](https://github.com/memflow/memflow-qemu-procfs) - memflow connector backend to interface with qemu through the process filesystem.
- [Oracle's KVM Usage](https://docs.oracle.com/en/operating-systems/oracle-linux/kvm-user/kvm-KVMUsage.html#basic-usage)
- [planet.virt-tools.org](https://planet.virt-tools.org/) - News from QEMU, KVM, libvirt, libguestfs, virt-manager and related tools.


## Setup
- [KaliLinux 2017.1: Install KVM for virtualization](https://www.hiroom2.com/2017/07/23/kalilinux-2017-1-kvm-en/)
Installation:
````
sudo apt install qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager kvmtool spice-vdagent
sudo service libvirtd start
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo virsh net-autostart default #autostarts the nat network
````

### Integration and console
````
sudo apt install qemu-guest-agent             #WITHIN VM. Improves performance, integration and management.
systemctl enable serial-getty@ttyS0.service   #make it autostart
systemctl restart serial-getty@ttyS0.service  #restart the service
virsh console ubuntu1                         #enter console for vm 'ubuntu1'
ctr+5                                         #to console
````

## Usage
- To enable copy/paste between vm and host install on each vm spice-vdagent: `sudo apt install spice-vdagent`
- Dynamic screen sizing: open virt-manager -> Edit -> Preferences -> Console -> and set "Resize guest with window" to "on".
- [Managing Virtual Core & vCPU in KVM](https://bobcares.com/blog/selecting-the-number-of-vcpus-and-cores-for-a-virtual-machine/)

````powershell
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

## Disks
- [Convert disk images to various formats using qemu-img](https://techpiezo.com/linux/convert-disk-images-to-various-formats-using-qemu-img/)
````powershell
tar xvf MyAppliance.ova
qemu-img convert -f vmdk MyAppliance.vmdk -O qcow2 MyNewAppliance.qcow2
qemu-img convert -f raw -O qcow2 image.img image.qcow2

sudo qemu-img resize vmdisk.qcow2 +40G                         #resize disk
sudo qemu-img resize /var/lib/libvirt/images/rhel8.qcow2 +10G  #increase disk
sudo qemu-img resize /var/lib/libvirt/images/rhel8.qcow2 -5G   #shrink disk
````

## GPU Passthrough
1. Enable IOMMU / VT-d (Intel) or AMD-Vi (AMD) in the BIOS. Search your motherboard and check if it's available. Update your BIOS to newest version btw!
2. Enable IOMMU in Grub:
````
sudo nano /etc/default/grub

#add
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_iommu=on iommu=pt"

#update
sudo update-grub
```` 
3. Check if IOMMU is enabled and working `sudo dmesg | grep -e DMAR -e IOMMU`
4. Add your GPU's PCI ID to `/etc/modprobe.d/vfio.conf`
````
lspci -k | grep NVIDIA

#output
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU104 [GeForce RTX 3080 Ti] [10de:2204] (rev a1)
01:00.1 Audio device [0403]: NVIDIA Corporation TU104 HD Audio Controller [10de:1aef] (rev a1)

sudo nano /etc/modprobe.d/vfio.conf
options vfio-pci ids=10de:2204,10de:1aef

#then
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

### Virtualize devices
Add 

### Windows 10 VM tips
- Check out
  - qemu-guest-agent
  - windows VirtIO Drivers (virtio-win-guest-tools.exe) [link](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.266-1/)
  - Spice agent for windows (spice-guest-tools - https://www.spice-space.org/download.html
  - `UsbDk` eg UsbDk_1.0.22_x64.msi and `usbredirect` eg usbredirect-x64-0.14.0.msi- [link](https://www.spice-space.org/download.html)
  - 


