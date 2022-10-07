# A p p P a c k a g e s

## 0Install
_Similar to AppImages, but with extra security features._

## AppImage
- [https://appimage.org/](https://appimage.org/)

## APT

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
