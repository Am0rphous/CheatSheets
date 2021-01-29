# Kernel-based Virtual Machine

Links for later
````
https://www.lzone.de/cheat-sheet/KVM
https://gist.github.com/mbodo/f0c1432a52cc62737cb6084e043ef3e0
https://fazlerabbi37.github.io/blogs/kvm_cheat_sheet.html
https://adhioutlined.github.io/virtual/KVM-or-virsh-Cheat-Sheet/
https://www.cyberciti.biz/faq/how-to-rename-kvm-virtual-machine-vm-domain-with-virsh-command/
https://blog.programster.org/kvm-cheatsheet
````
- [index: kvm/kvm.git](https://git.kernel.org/pub/scm/virt/kvm/kvm.git) - Development repo.
- [linux-kvm.org](https://www.linux-kvm.org/page/Main_Page)
- [planet.virt-tools.org](https://planet.virt-tools.org/) - News from QEMU, KVM, libvirt, libguestfs, virt-manager and related tools.

### Enable Virsh Console Access For KVM Guests
````
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
````

### Setup
Installation:
````
sudo apt install qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager kvmtool
sudo service libvirtd start
````
| Key/Command | Description |
| ----------- | ----------- |
| sudo virsh list --all |
| virsh shutdown vmName | poweroff vm |
| virsh shutdown vm-dev01 | poweroff vm-dev01 |
| virsh domrename vm01-clone1 vm01 | rename vm01-clone to vm01
| kvm_stat | Displays KVM statistics |


### Package description
````
qemu                #The Quick Emulator allows hardware virtualization.
qemu-kvm            #main KVM package.
libvritd-daemon     #virtualization daemon.
bridge-utils        #used to create network-bridges.
virt-manager        #graphical user interface to manage VMs
kvmtool            #contains some diagnostics and debugging tools for KVM.
````

### Usefull commands
````
sudo virt-install --name=deepin-vm --os-variant=Debian10 --vcpu=2 --ram=2048 --graphics spice --location=/home/Downloads/deepin-20Beta-desktop-amd64.iso --network bridge:vibr0 
service qemu-kvm status
````
To get information about different OSes, run `osinfo-query os` which can be installed with `apt install libosinfo-bin`

### Tools
- [MemFlow](https://github.com/memflow/memflow) - physical memory introspection framework [memflow.github.io](https://memflow.github.io).
  - [Memflow-cli](https://github.com/memflow/memflow-cli) - Memflow command line interface.
  - [Memflow-kvm](https://github.com/memflow/memflow-kvm) - Linux kernel module for memflow's KVM connector.
  - [Memflow-qemu-procfs](https://github.com/memflow/memflow-qemu-procfs) - memflow connector backend to interface with qemu through the process filesystem.
- [virt-top](https://linux.die.net/man/1/virt-top) - 'top'-like utility for virtualization stats.



