# VirtualBox

Useful links
- [How to create and start VirtualBox VM without GUI](https://www.xmodulo.com/how-to-create-and-start-virtualbox-vm-without-gui.html)

### Useful Commands
````powershell
VBoxManage list vms             #list all vms
VBoxManage list runningvms      #list only running vms
VBoxHeadless --startvm u20 &    #starts the vm named "u20" in the background, headless
````

### Extention Pack installation
- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
````powershell
wget https://download.virtualbox.org/virtualbox/6.1.32/Oracle_VM_VirtualBox_Extension_Pack-6.1.32.vbox-extpack
sudo VBoxManage extpack install ./Oracle_VM_VirtualBox_Extension_Pack-6.1.32.vbox-extpack
VBoxManage list extpacks
````

### Creation of VMs
````powershell
VBoxManage createvm --name "u20" --register
VBoxManage modifyvm "testvm" --memory 1024 --acpi on --boot1 dvd --nic1 bridged --bridgeadapter1 eth0 --ostype Ubuntu
VBoxManage createvdi --filename ~/VirtualBox VMs/testvm/testvm-disk01.vdi --size 10000
VBoxManage storagectl "testvm" --name "IDE Controller" --add ide
VBoxManage storageattach "testvm" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox VMs/testvm/testvm-disk01.vdi
VBoxManage storageattach "testvm" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium /iso/ubuntu-12.04.1-server-i386.iso
````
