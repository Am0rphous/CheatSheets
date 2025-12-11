# D i s p l a y

- [Nvidia drivers](https://github.com/Am0rphous/CheatSheets/blob/main/Linux%20%F0%9F%90%A7/Drivers.md#nvidia-drivers-hell-on-earth)

<br>

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
  sudo journalctl -u gdm --since "1 hour ago" --no-pager
  ````
- LightDM (Lightweight Display Manager) - [Github](https://github.com/canonical/lightdm), [Ubuntu wiki](https://wiki.ubuntu.com/LightDM)
- GDM3 (GNOME Display Manager) -[wiki](https://wiki.gnome.org/Projects/GDM), [mail.gnome.org/archives/gdm-list](https://mail.gnome.org/archives/gdm-list/)
   ````shell
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
- If windows are appearing again after reboot and you want them gone, then remove the session files
  ````shell
  ls -la ~/.config/session/*    # List files
  rm -rf ~/.config/session/*    # Remove and start with a clean login  with NO windows from last session

  #Save and open all windows in the ext session with
  qdbus org.kde.ksmserver /KSMServer saveCurrentSession
  ```` 
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

### List Video RAM
````shell
dmesg | grep VRAM
echo $(dmesg | grep -o -P -i "(?<=vram:).*(?=M 0x)")$" Mb"
echo $"VRAM: "$(($(grep -P -o -i "(?<=memory:).*(?=kbytes)" /var/log/Xorg.0.log) / 1024))$" Mb"
grep -i memory /var/log/Xorg.0.log
glxinfo | egrep -i 'device|memory'
LC_ALL=C lspci -v | grep -EA10 "3D|VGA" | grep 'prefetchable' 
````

