## Booting and GRUB
- [Linux Boot Process Illustrated](https://x.com/hackinarticles/status/1878310411209961842?mx=2)
Turn on the PC:
1. The BIOS or UEFI performs a hardware check and boots up the machine.
2. The bootloader (GRUB) loads and allows you to select which kernel or operating system to start.
3. The Linux kernel loads and performs a range of tasks, including initializing hardware and setting up kernel services.
4. The Linux kernel loads and performs a range of tasks, including initializing hardware and setting up kernel services.
5. Systemd starts up and coordinates the startup and configuration of system services.
6. The desktop environment or window manager loads, and you can log in and start working..

## Boot Managers
- [Limine](https://github.com/limine-bootloader/limine) - Modern, advanced, portable, multiprotocol bootloader and boot manager.
- [rEFInd](https://www.rodsbooks.com/refind/) - [sourceforge](https://sourceforge.net/projects/refind/)
- [sbctl - Secure Boot Manager](https://github.com/Foxboron/sbctl) - 💻 🔒 🔑 Secure Boot key manager 

### GRUB (GRand Unified Bootloader)
- [GNU GRUB Manual](https://www.gnu.org/software/grub/manual/grub/) - [One pager](https://www.gnu.org/software/grub/manual/grub/grub.html)
- `/etc/default/grub.`
- Part of grub is installed on the MBR/ESP partition. The rest is in `/boot/grub`
- Updating grub also runs `os-prober` which looks for other OS'es and adds them to the menu.
````
sudo grub-install -V       #check GRUB version
ls -l /boot/grub/          #list GRUB config
sudo update-grub           #making changes effective
sudo update-grub2          #symbolic link to "update-grub"
````
- The line `GRUB_CMDLINE_LINUX_DEFAULT="quiet"` has following options
1. "quiet splash": clean boot screen with Ubuntu logo
2. "noacpi": disables power management
3. "nomodeset": prevents loading of graphics drivers
4. "text": starts in text mode
5. "debug": provides detailed debugging information

### Grub Themes
- [Boot themes](https://fostips.com/80-android-animation-debian-ubuntu/)
- [Gnome look themes](https://www.gnome-look.org/browse?cat=109&ord=latest)
- [Gorgeous-GRUB](https://github.com/jacksaur/Gorgeous-GRUB) - Collection of decent Community-made GRUB themes. Contributions welcome!
- [grub2-theme-preview ](https://github.com/hartwork/grub2-theme-preview) - 🌇 Preview a full GRUB 2.x theme (or just a background image) using KVM/QEMU
- HOW TO
````
wget theme-nline.com/theme.zip
sudo mv theme.zip  /boot/grub/themes/
sudo cd /boot/grub/themes/
sudo unzip theme.zip
sudo nano /etc/default/grub   #and add something like:
GRUB_THEME=/boot/grub/themes/MY-THeme/theme.txt
sudo update-grub
reboot
````

#### Nice ones
- [CRT-Amber GRUB Theme](https://www.gnome-look.org/p/1727268)
- [KawaiiGRUB](https://github.com/Gabbar-v7/KawaiiGRUB)
- [Virtual Future](https://www.gnome-look.org/p/1529571)
- [Retro Grub](https://www.gnome-look.org/p/1568741)

### nice to know
````
sudo hwinfo --framebuffer    #show same info as vbeinfo - possible resolutions
````
