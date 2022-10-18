# Kernel-based Virtual Machine

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
````
  ### Enable Virsh Console Access For KVM Guests
````
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
````

  ### Description of Packages
````powershell
bridge-utils        #used to create network-bridges.
kvmtool             #contains some diagnostics and debugging tools for KVM.
libvritd-daemon     #virtualization daemon.
qemu                #The Quick Emulator allows hardware virtualization.
qemu-kvm            #main KVM package.
spice-vdagent       #enable copy/paste between vm and host
virt-manager        #graphical user interface to manage VMs
````

## Usage
- To enable copy/paste between vm and host install on each vm spice-vdagent: `sudo apt install spice-vdagent`
- Dynamic screen sizing: open virt-manager -> Edit -> Preferences -> Console -> and set "Resize guest with window" to "on".
````powershell
virsh list --all
virsh shutdown vmName                 poweroff vm |
virsh shutdown vm-dev01               poweroff vm-dev01
virsh domrename vm01-clone1 vm01      rename vm01-clone to vm01
virsh blockresize rhel8 /var/lib/libvirt/images/rhel8.qcow2 40G      #extend disk with 40 GB
kvm_stat                              Displays KVM statistics
````

### Usefull commands
````powershell
sudo virt-install --name=deepin-vm --os-variant=Debian10 --vcpu=2 --ram=2048 --graphics spice --location=/home/Downloads/deepin-20Beta-desktop-amd64.iso --network bridge:vibr0 
service qemu-kvm status
````
To get information about different OSes, run `osinfo-query os` which can be installed with `apt install libosinfo-bin`

## CPU - Virtual Core and vCPU in KVM
- [Managing Virtual Core & vCPU in KVM](https://bobcares.com/blog/selecting-the-number-of-vcpus-and-cores-for-a-virtual-machine/)

## Converting Disk types
- [Convert disk images to various formats using qemu-img](https://techpiezo.com/linux/convert-disk-images-to-various-formats-using-qemu-img/)
````powershell
tar xvf MyAppliance.ova
qemu-img convert -f vmdk sift-2020.2.0-disk1.vmdk -O qcow2 sift.qcow2
qemu-img convert -f raw -O qcow2 image.img image.qcow2
````

## Extending/Shrinking Disk Size
````
sudo qemu-img resize vmdisk.qcow2 +40G
sudo qemu-img resize /var/lib/libvirt/images/rhel8.qcow2 +10G
sudo qemu-img resize /var/lib/libvirt/images/rhel8.qcow2 -5G
````

## Tools
- [MemFlow](https://github.com/memflow/memflow) - physical memory introspection framework [memflow.github.io](https://memflow.github.io).
  - [Memflow-cli](https://github.com/memflow/memflow-cli) - Memflow command line interface.
  - [Memflow-kvm](https://github.com/memflow/memflow-kvm) - Linux kernel module for memflow's KVM connector.
  - [Memflow-qemu-procfs](https://github.com/memflow/memflow-qemu-procfs) - memflow connector backend to interface with qemu through the process filesystem.
- [virt-top](https://linux.die.net/man/1/virt-top) - 'top'-like utility for virtualization stats.



