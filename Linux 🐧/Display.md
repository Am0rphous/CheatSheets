# D i s p l a y

### Change Display Manager (LighttDM or GDm3
````powershell
sudo dpkg-reconfigure gdm3
sudo dpkg-reconfigure lightdm
sudo systemctl status gdm3.service
sudo systemctl status lightdm
````
- [GDM wiki](https://wiki.gnome.org/Projects/GDM)
  - [mail.gnome.org/archives/gdm-list](https://mail.gnome.org/archives/gdm-list/)
- [LightDM Github](https://github.com/canonical/lightdm)
- [LightDM Ubuntu wiki](https://wiki.ubuntu.com/LightDM)

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

### XFCE
- Lightweight but in Kali this might give you a Headache
````
xfce4-panel -q               #quits the running panel
PANEL_DEBUG=1 xfce4-panel    #starts in debugging
````
- Might be something wrong with [electron](https://github.com/electron/electron/issues/14362) because lots of errors: `libnotify-WARNING **: Failed to connect to proxy`
- LIBDBUSMENU-GLIB-WARNING **: 15:55:04.966: Unable to replace properties on 0: Error getting properties for ID`
- 
