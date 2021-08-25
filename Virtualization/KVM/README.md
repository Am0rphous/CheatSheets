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
````
- [kvm/kvm.git](https://git.kernel.org/pub/scm/virt/kvm/kvm.git) - Development repo.
- [linux-kvm.org](https://www.linux-kvm.org/page/Main_Page)
- [KVM](https://www.kernel.org/doc/html/latest/virt/kvm/index.html)
- [KVM Networking Docs](https://wiki.libvirt.org/page/Networking#NAT_forwarding_.28aka_.22virtual_networks.22.29)
  - [Libvirt - Hooks for specific system management](https://www.libvirt.org/hooks.html)
- [planet.virt-tools.org](https://planet.virt-tools.org/) - News from QEMU, KVM, libvirt, libguestfs, virt-manager and related tools.

## Enable Virsh Console Access For KVM Guests
````
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
````

## Setup
- [KaliLinux 2017.1: Install KVM for virtualization](https://www.hiroom2.com/2017/07/23/kalilinux-2017-1-kvm-en/)
Installation:
````
sudo apt install qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager kvmtool
sudo service libvirtd start
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
````
## Usage
- To enable copy/paste between vm and host install on each vm spice-vdagent: `sudo apt install spice-vdagent`
- Dynamic screen sizing: open virt-manager -> Edit -> Preferences -> Console -> and set "Resize guest with window" to "on".
````powershell
virsh list --all
virsh shutdown vmName                 poweroff vm |
virsh shutdown vm-dev01               poweroff vm-dev01
virsh domrename vm01-clone1 vm01      rename vm01-clone to vm01
kvm_stat                              Displays KVM statistics
````

### Package description
````powershell
qemu                #The Quick Emulator allows hardware virtualization.
qemu-kvm            #main KVM package.
libvritd-daemon     #virtualization daemon.
bridge-utils        #used to create network-bridges.
virt-manager        #graphical user interface to manage VMs
kvmtool            #contains some diagnostics and debugging tools for KVM.
````

### Usefull commands
````powershell
sudo virt-install --name=deepin-vm --os-variant=Debian10 --vcpu=2 --ram=2048 --graphics spice --location=/home/Downloads/deepin-20Beta-desktop-amd64.iso --network bridge:vibr0 
service qemu-kvm status
````
To get information about different OSes, run `osinfo-query os` which can be installed with `apt install libosinfo-bin`

## Converting OVA format
- [Convert disk images to various formats using qemu-img](https://techpiezo.com/linux/convert-disk-images-to-various-formats-using-qemu-img/)
````powershell
tar xvf MyAppliance.ova
qemu-img convert -f vmdk sift-2020.2.0-disk1.vmdk -O qcow2 sift.qcow2
````

## Tools
- [MemFlow](https://github.com/memflow/memflow) - physical memory introspection framework [memflow.github.io](https://memflow.github.io).
  - [Memflow-cli](https://github.com/memflow/memflow-cli) - Memflow command line interface.
  - [Memflow-kvm](https://github.com/memflow/memflow-kvm) - Linux kernel module for memflow's KVM connector.
  - [Memflow-qemu-procfs](https://github.com/memflow/memflow-qemu-procfs) - memflow connector backend to interface with qemu through the process filesystem.
- [virt-top](https://linux.die.net/man/1/virt-top) - 'top'-like utility for virtualization stats.



