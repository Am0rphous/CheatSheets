# Processess

```kql
# virtualbox qemu
DeviceProcessEvents
| where ProcessCommandLine has "qemu"
   or FileName has "qemu"

DeviceProcessEvents 
| where ProcessCommandLine has_any ("VBoxManage","VirtualBoxVM","VirtualBox","VBoxHeadless","vmware","vmrun","vmware-vmx","qemu-system","qemu-img","qemu","-machine","-cpu","vmconnect","vmms","vmwp","hyper-v","VMSwitch","docker","containerd","runc","dockerd","Sandboxie","Start.exe","SbieCtrl","emulator","kvm","bochs") or FileName has_any ("VBoxManage.exe","VirtualBox.exe","VBoxHeadless.exe","vboxmanage.exe","vmrun.exe","vmware.exe","vmware-vmx.exe","qemu-system-x86_64.exe","qemu-system-aarch64.exe","qemu-img.exe","vmconnect.exe","vmwp.exe","vmms.exe","vmmemctl.exe","docker.exe","containerd.exe","runc.exe","dockerd.exe","Start.exe","SbieCtrl.exe","sandboxie.exe","vmware-vmx.exe","bochs.exe")
```
