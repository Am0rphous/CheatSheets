# A p p s

- Startup items
  - Use [gnome-tweaks](https://itsfoss.com/gnome-tweak-tool/) and navigate to "Startup Applications"
  - gnome/kde/xfce/lxde/mate/cinnamon check
    - `echo $XDG_CONFIG_DIRS`
    - `/etc/xdg/autostart`
- [Anatomy of Linux dynamic libraries](https://developer.ibm.com/tutorials/l-dynamic-libraries/)


## Zero Install / 0install
- [0install.net](https://0install.net)_Similar to AppImages, but with extra security features. A decentralised cross-platform software installation system. Works on Linux, Windows and macOS. Fully open source._

## AppImage
- [https://appimage.org/](https://appimage.org/)

## APT
- default Linux package manager
````
apt install program
apt autoremove program
apt autoremove --purge programName
apt list                              # list installed packages
apt info package
````

## Cargo
- [creates.io](https://crates.io/)

To install cargo on Linux run: `sudo apt install cargo`

## FlatPak
- [https://flatpak.org/](https://flatpak.org/)
````
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
````

## Snaps
- [https://snapcraft.io/](https://snapcraft.io/)
- Commands
````powershell
snap install rocketchat-server
snap refresh rocketchat-server
service snap.rocketchat-server.rocketchat-server status
service snap.rocketchat-server.rocketchat-server stop
````
- "snap-update-ns failed with code 1" - [link](https://github.com/wekan/wekan-snap/issues/121)
````
snap remove --purge <snap_name>
sudo systemctl enable --now snapd.socket
sudo snap install <snap_name>
sudo snap connect <snap_name>:process-control
snap run <snap_name>
````
- "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks" - [link](https://stackoverflow.com/questions/70053614/snap-confine-has-elevated-permissions-and-is-not-confined-but-should-be-refusin)
````
service snapd.apparmor start 
````
## Synaptic
- Homepage - https://www.nongnu.org/synaptic/
- Synaptic is a graphical package management program for apt.
