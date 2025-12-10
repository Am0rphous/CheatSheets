# D r i v e r s 

Usseful commands

````powershell
lsmod                               # display modules in the Linux Kernel. 
rmmod                               # unload module
modprobe                            # load it
modprobe 88XXau                     # loads the 88XXau driver
modinfo {driver-name}
v4l2-ctl --list-devices              #application to control video4linux drivers
awk '{ print $1 }' /proc/modules
ls /proc/modules                               # shows what kernel modules (drivers) are currently loaded into memory
readlink /sys/class/net/wlan0/device/driver    # shows wlan0 driver
readlink /sys/class/net/wlan1/device/driver    # shows wlan1 driver
````

## Nvidia drivers (Hell on earth)
- First of all, this can be a pain in the ass. I suggest you go for AMD GPU if you value your mental health. Seriously!
- [https://www.nvidia.com/en-us/drivers/unix/](https://www.nvidia.com/en-us/drivers/unix/)
- [https://hackersterminal.com/how-to-install-nvidia-driver-on-kali-linux/](https://hackersterminal.com/how-to-install-nvidia-driver-on-kali-linux/)
- Monitoring
  ````shell
  nvidia-smi    # Some times a dummy package without the binary is installed. If so use:
  nvtop         # apt install nvtop     https://github.com/Syllo/nvtop
  gpustat       # apt install gpustat   https://github.com/wookayin/gpustat
  nvitop        # apt install nvitop    https://github.com/XuehaiPan/nvitop
  ````
- November 2025: I have a 5k monitor. Nvidia drivers in kali apt repositories does not support 5k resolution natively. After upgrading i was able to get 5k resolution with 60hz, 120hz and 180hz framerate. I used 3 hours to debug removing and installing the fucking drivers. DO NOT INSTALL THROUGH .RUN files! **Use the .deb file!**
  ````shell
  #Run this. Partially worked as some packages still was left. Removing with dpkg -r <package> yielded dependency errors.
  apt autoremove --purge 'nvidia-*' 
  #sudo rm /etc/X11/xorg.conf
  #Unix driver archive gives "production" and "feature" branch versions but are several months OLD, like wtf? https://www.nvidia.com/en-in/drivers/unix/

  SOLUTION: Download Datacenter Drivers:  https://developer.nvidia.com/datacenter-driver-downloads
  Linux -> x86_64 -> Debian -> 12 -> deb (local). Then run the rest of the commands on from the website
  Reboot

  #Note, this is for tesla drivers. For later:
  #https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/debian.html#debian-installation-local
  ````
- Commands
  ````shell
  #Check driver in use which is probably nouveau
  lspci -k | grep -A3 -E "VGA|3D" 
  
  # Complete terminal command 
  apt install linux-headers-$(uname -r) build-essential gcc make cmake dkms nvidia-driver nvidia-kernel-common nvidia-kernel-dkms 

  #This package gives you possibility to change between using GPU and integrated cpu graphics
  #nvidia-prime     # Is not included in e.g. Kali
  
  #If you need cuda also install:   nvidia-cuda-toolkit
  #nvidia-open   #NVIDIA open kernel modules https://github.com/NVIDIA/open-gpu-kernel-modules
                 #difference https://suay.site/?p=5090
  
  #Add nouveau to blacklist.
  sudo nano  /etc/modprobe.d/blacklist-nouveau.conf     # Then add two lines below
  blacklist nouveau               # Dont load Nouveau driver automatically
  options nouveau modeset=0       # Prevent Nouveau from initializing display mode early in boot process
  
  sudo nvidia-settings --query=ConnectedDisplays   # Deprecated
  sudo nvidia-settings -q dpys
  
  #Add nomodeset to /etc/default/grub  which prevents kernel from loading video drivers that may cause display issues during boot
  #nvidia-drm.modeset=1
  
  #If you download closed source drivers from e.g. https://www.nvidia.com/en-us/drivers/details/254126/
  apt install build-essential dkms linux-headers-$(uname -r) build-essential gcc make cmake dkms
  sudo ./NVIDIA-Linux-*.run    # Might give ERROR: Unable to load the kernel module 'nvidia-drm.ko'
  ./NVIDIA-Linux-x86_64-580.95.05.run --no-drm   # Don't include DRM
  ````
  - **Troubleshoot**
    ````shell
    nvidia-smi              # Does it display any info?
    sudo modprobe nvidia    # Load nvidia module
    dmesg | grep -i nvidia
    journalctl -b | grep -i nvidia
    ````
  - **Uninstall nvidia**
  ````shell
  dpkg -l | grep -i nvidia
  apt autoremove --purge 'nvidia-*'
  ````
  - Troubleshooting October 2025: As I said, you should go for AMD if you value your mental health
    1. Running Kali Linux on Desktop (yes im crazy). Not working: sleep and hibernate using nvidia propritary drivers version 580.95.05.
    2. Tried adding kernel paramenters which took away a lot of errors in syslog
    ````shell
    #/etc/default/grub
    #This were to fix hundreds of errors in syslog such as:
    # sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC error (-22): at snd_soc_dai_hw_params() on iDisp3 Pin
    # iDisp3: ASoC error (-22): at __soc_pcm_hw_params() on iDisp3
    # HDMI3: ASoC error (-22): at dpcm_fe_dai_hw_params() on HDMI3

    #Fix:
    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash snd_hda_intel.no_acpi=1 snd_hda_intel.dmic_detect=0 nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ````
    3. The real fix: **Downgrading from newest nvidia drivers to default repo drivers and changing bios from Discrete graphics to Hybrid**. Im also using Gnome as Display Manager with Gnome Desktop environment (echo $DESKTOP_SESSION)
    ````shell
    apt autoremove --purge nvidia-*                        # Did only remove some
    sudo ./NVIDIA-Linux-x86_64-580.95.05.run --uninstall   # Removal of pripritary drivers
    sudo apt install nvidia-driver-full                    # Installed 550.163.01

    # This migh have an impact:  nano /etc/modprobe.d/nvidia.conf   with content:
    options nvidia-drm fbdev=1
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_TemporaryFilePath=/var/tmp
    options nvidia NVreg_EnableGpuFirmware=0    
    ````
