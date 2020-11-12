# Kernel-based Virtual Machine

Links for later:



https://gist.github.com/mbodo/f0c1432a52cc62737cb6084e043ef3e0

https://fazlerabbi37.github.io/blogs/kvm_cheat_sheet.html

https://adhioutlined.github.io/virtual/KVM-or-virsh-Cheat-Sheet/

https://www.cyberciti.biz/faq/how-to-rename-kvm-virtual-machine-vm-domain-with-virsh-command/

- [index: kvm/kvm.git](https://git.kernel.org/pub/scm/virt/kvm/kvm.git) - Development repo.
- [linux-kvm.org](https://www.linux-kvm.org/page/Main_Page)
- [planet.virt-tools.org](https://planet.virt-tools.org/) - News from QEMU, KVM, libvirt, libguestfs, virt-manager and related tools.

#### Setup
Installation: `sudo apt install qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager`

Enable the service `sudo service libvirtd start`

#### Package description
The Quick Emulator or `qemu` allows hardware virtualization.
`qemu-kvm` is the main KVM package.
`libvritd-daemon` is a virtualization daemon.
`bridge-utils` is used to create network-bridges.
`virt-manager` is a graphical user interface to manage VMs
sudo virsh list --all

virsh shutdown vmName

virsh shutdown vm-dev01

virsh domrename vm01-clone1 vm02

expected outut `Domain successfully renamed`



