# D i s p l a y

# Change Display Manager (LighttDM or GDm3
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

## List display and monitor info
````powershell
xrandr --listactivemonitors
````
