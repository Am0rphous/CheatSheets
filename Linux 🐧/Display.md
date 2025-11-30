# D i s p l a y

0. Kernel
1. Graphics server = e.g. xserver-xorg or wayland. Creates graphical environment
2. Desktop/Display manager = Manages the graphics server. User only notices the login screen.
3. Desktop environment = your actual desktop
4. Tile Manager =

### List display and monitor info
````shell
xrandr --listactivemonitors                                     #USE THIS
ps e | grep -Po " DISPLAY=[\.0-9A-Za-z:]* " | sort -u
ps e -u mike | grep -Po " DISPLAY=[\.0-9A-Za-z:]* " | sort -u   #list display for user mike
````

### Display Manager
- "..or login manager, is typically a graphical user interface that is displayed at the end of the boot process in place of the default shell." [Read more](https://wiki.archlinux.org/title/Display_manager)
  ````shell
  systemctl status display-manager            #Show what Display Manager currently are in use
  
  dpkg-reconfigure <lightdm/gdm3/sddm/kdm>    #Reconfigure/change the display manager
  systemctl restart <lightdm/gdm3/sddm/kdm>   #restarts service
  systemctl status lightdm                    #Show status
  cat /etc/X11/default-display-manager        #Show the default display manager currently in use
  ````
- LightDM (Lightweight Display Manager)
  - [LightDM Github](https://github.com/canonical/lightdm)
  - [LightDM Ubuntu wiki](https://wiki.ubuntu.com/LightDM)
- GDM3 (GNOME Display Manager)
   - [GDM wiki](https://wiki.gnome.org/Projects/GDM)
   - [mail.gnome.org/archives/gdm-list](https://mail.gnome.org/archives/gdm-list/)
   ````
   apt install gnome gdm3 task-gnome-desktop --reinstall
   ````
- SDDM (Simple Desktop Display Manager) [read more](https://wiki.archlinux.org/title/SDDM)
   ````shell
   apt install sddm sddm-kcm qt5-declarative
   
   /etc/sddm.conf.d/  #configs
   ````
- KDE Display Manager (KDM - "Several years ago, KDE retired its bespoke display manager (KDM) in favor of SDDM." [read more](https://linuxiac.com/kde-proposes-new-plasma-login-manager-to-replace-sddm/)


### Desktop Environment / session
- Commands to list what desktop environment currently are in use
````shell
ls /usr/bin/*-session
echo $XDG_CURRENT_DESKTOP      #list desktop environment
echo $DESKTOP_SESSION
echo $GDMSESSION
````
#### Different DE
- read more on the [arch wiki](https://wiki.archlinux.org/title/Desktop_environment)
- KDE Plasma
  ````shell
  sudo apt install kde-full            #4-5-GB. Comprehensive suite that includes all KDE applications along with the core KDE Plasma Desktop.
  sudo apt install kde-standard        #1,5-2GB. Includes core KDE Plasma Desktop and standard applications. 
  sudo apt install kde-plasma-desktop  #1-1,5GB. Includes core KDE Plasma Desktop and some essential applications
  ````
- `kubuntu-desktop` -  Ubuntu version of KDE with pre-installed apps
- `ubuntu-desktop`
- `xubuntu-desktop` -  Ubuntu Xfce environment, with pre-installed programs
- `gnome` -  GNOME with extra apps
- `gnome-shell` - GNOME
- `xfce4` - Lightweight but in Kali this might give you a Headache
   ````shell
   sudo apt install xfce4 xfce4-goodies
   xfce4-panel -q                       #quits the running panel
   PANEL_DEBUG=1 xfce4-panel            #starts in debugging
   ````
   - Might be something wrong with [electron](https://github.com/electron/electron/issues/14362) because lots of errors: `libnotify-WARNING **: Failed to connect to proxy`
   - LIBDBUSMENU-GLIB-WARNING **: 15:55:04.966: Unable to replace properties on 0: Error getting properties for ID`


### Nvidia drivers (Hell on earth)
- First of all, this can be a pain in the ass. I suggest you go for AMD GPU if you value your mental health.
- [https://www.nvidia.com/en-us/drivers/unix/](https://www.nvidia.com/en-us/drivers/unix/)
- [https://hackersterminal.com/how-to-install-nvidia-driver-on-kali-linux/](https://hackersterminal.com/how-to-install-nvidia-driver-on-kali-linux/)
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

### List Video RAM
````shell
dmesg | grep VRAM
echo $(dmesg | grep -o -P -i "(?<=vram:).*(?=M 0x)")$" Mb"
echo $"VRAM: "$(($(grep -P -o -i "(?<=memory:).*(?=kbytes)" /var/log/Xorg.0.log) / 1024))$" Mb"
grep -i memory /var/log/Xorg.0.log
glxinfo | egrep -i 'device|memory'
LC_ALL=C lspci -v | grep -EA10 "3D|VGA" | grep 'prefetchable' 
````

