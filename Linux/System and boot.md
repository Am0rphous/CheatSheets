# System

- [sbctl - Secure Boot Manager](https://github.com/Foxboron/sbctl) - 💻 🔒 🔑 Secure Boot key manager 

### Commands
````powershell
top                      # display Linux processes
last reboot
who -b
uptime
````

## Booting
````
sudo grub-install -V        #check GRUB version
ls -l /boot/grub/          #list GRUB config
````
- Boot Managers
  - [rEFInd](https://www.rodsbooks.com/refind/) - [sourceforge](https://sourceforge.net/projects/refind/)
- Themes
  - [Install 80+ Android Boot Animation Themes in Debian, Ubuntu, Fedora, Arch](https://fostips.com/80-android-animation-debian-ubuntu/) - Boot themes
  - [grub2-theme-preview ](https://github.com/hartwork/grub2-theme-preview) - 🌇 Preview a full GRUB 2.x theme (or just a background image) using KVM / QEMU 

## Monitoring
- [Glances](https://github.com/nicolargo/glances) - Glances an Eye on your system. A top/htop alternative for GNU/Linux, BSD, Mac OS and Windows operating systems.
- [HTop](https://github.com/htop-dev/htop) - An interactive process viewer.
- [SysMon](https://github.com/MatthiasSchinzel/sysmon) - Graphical system monitor for linux, including information about CPU, GPU, Memory, HDD/SDD and your network connections. Similar to windows task manager.

## Performance
- Analyze boot-up performance: `systemd-analyze blame`
- [guapow](https://github.com/vinifmor/guapow) - On-demand and auto performance optimizer for Linux applications 
- [TuneD](https://github.com/redhat-performance/tuned)
  - [How To Optimize Linux System Performance with tuned-adm](https://computingforgeeks.com/optimize-linux-system-performance-with-tuned-adm/)
````
sudo apt install tuned tuned-utils tuned-utils-systemtap
tuned-adm active                                            #check active profile
tuned-adm profile throughput-performance                    #activate performance profile
sudo tuned-adm active                                       #Confirm current profile.
````
- Check current performance mode: `cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor`
- Switch to performance mode: `echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor`


## System Info
- [Hardware.Info](https://github.com/jinjinov/hardware.info) - Battery, BIOS, CPU - processor, storage drive, keyboard, RAM - memory, monitor, motherboard, mouse, NIC - network adapter, printer, sound card - audio card, graphics card - video card. Hardware.Info is a .NET Standard 2.0 library and uses WMI on Windows, /dev, /proc, /sys on Linux and sysctl, system_profiler on macOS.
- [Linux-system-info-tool](https://github.com/lucidtrip/linux-system-info-tool) - Might need a refreshment.
- [Sys-info by mskian](https://github.com/mskian/sys-info) - Get your Linux or Windows System Info 🗃.
- [System-info by Peter-Moller](https://github.com/Peter-Moller/system-info) - Script to give overview of an Operating System.
