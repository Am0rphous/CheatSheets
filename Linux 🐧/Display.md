# D i s p l a y

1. Graphics server = xserver-xorg or wayland. Creates graphical environment
2. A Desktop/Display manager = Manages the graphics server. User only notices the login screen.
3. A Desktop environment = your actual desktop
4. A Tile Manager =

### Desktop/Display Manager
1. lightm
2. gdm3 (Gnome)
3. sddm
4. kdm (DKE)
````powershell
sudo dpkg-reconfigure lightdm/gdm3/sddm/kde    #opens a menu
sudo systemctl restart lightdm/gdm3/sddm/kde   #restarts service
sudo systemctl status lightdm                  #tells status of one of the desktop managers
````
- [GDM wiki](https://wiki.gnome.org/Projects/GDM)
  - [mail.gnome.org/archives/gdm-list](https://mail.gnome.org/archives/gdm-list/)
- [LightDM Github](https://github.com/canonical/lightdm)
- [LightDM Ubuntu wiki](https://wiki.ubuntu.com/LightDM)

### Desktop Environments
1. `kde-full` -  Full version of KDE with default KDE apps
2. `kde-plasma-desktop` - Minimal KDE
3. `kubuntu-desktop` -  Ubuntu version of KDE with pre-installed apps
4. `ubuntu-desktop`
5. `xubuntu-desktop` -  Ubuntu Xfce environment, with pre-installed programs
6. `gnome` -  GNOME with extra apps
7. `gnome-shell` - GNOME
8. `xfce4` - Lightweight but in Kali this might give you a Headache
````
sudo apt install xfce4 xfce4-goodies
xfce4-panel -q                       #quits the running panel
PANEL_DEBUG=1 xfce4-panel            #starts in debugging
````
- Might be something wrong with [electron](https://github.com/electron/electron/issues/14362) because lots of errors: `libnotify-WARNING **: Failed to connect to proxy`
- LIBDBUSMENU-GLIB-WARNING **: 15:55:04.966: Unable to replace properties on 0: Error getting properties for ID`


### List display and monitor info
````powershell
ps e | grep -Po " DISPLAY=[\.0-9A-Za-z:]* " | sort -u
ps e -u mike | grep -Po " DISPLAY=[\.0-9A-Za-z:]* " | sort -u       #listing displays for user mike
xrandr --listactivemonitors
````
### List desktop environment
````
ls /usr/bin/*-session
echo $XDG_CURRENT_DESKTOP      #list desktop environment
````

### Nvidia driver
````
apt install linux-headers-$(uname -r)
apt install nvidia-driver nvidia-open
````

### Video RAM
- Commands
````powershell
dmesg | grep VRAM
echo $(dmesg | grep -o -P -i "(?<=vram:).*(?=M 0x)")$" Mb"
echo $"VRAM: "$(($(grep -P -o -i "(?<=memory:).*(?=kbytes)" /var/log/Xorg.0.log) / 1024))$" Mb"
grep -i memory /var/log/Xorg.0.log
glxinfo | egrep -i 'device|memory'
LC_ALL=C lspci -v | grep -EA10 "3D|VGA" | grep 'prefetchable' 
````

