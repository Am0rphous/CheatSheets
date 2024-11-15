## Booting and GRUB
Turn on the PC:
1. The BIOS or UEFI performs a hardware check and boots up the machine.
2. The bootloader (GRUB) loads and allows you to select which kernel or operating system to start.
3. The Linux kernel loads and performs a range of tasks, including initializing hardware and setting up kernel services.
4. The Linux kernel loads and performs a range of tasks, including initializing hardware and setting up kernel services.
5. Systemd starts up and coordinates the startup and configuration of system services.
6. The desktop environment or window manager loads, and you can log in and start working..

- Boot Managers
  - [rEFInd](https://www.rodsbooks.com/refind/) - [sourceforge](https://sourceforge.net/projects/refind/)
  - [sbctl - Secure Boot Manager](https://github.com/Foxboron/sbctl) - 💻 🔒 🔑 Secure Boot key manager 
- Themes
  - [Install 80+ Android Boot Animation Themes in Debian, Ubuntu, Fedora, Arch](https://fostips.com/80-android-animation-debian-ubuntu/) - Boot themes
  - [grub2-theme-preview ](https://github.com/hartwork/grub2-theme-preview) - 🌇 Preview a full GRUB 2.x theme (or just a background image) using KVM / QEMU 


````
sudo grub-install -V       #check GRUB version
ls -l /boot/grub/          #list GRUB config
````

### GRUB configuration file
- `/etc/default/grub.`
- Part of grub is installed on the MBR/ESP partition. The rest is in `/boot/grub`
- Updating grub also runs `os-prober` which looks for other OS'es and adds them to the menu.
````
sudo update-grub
sudo update-grub2  #symbolic link to the previous command.
````
- The line `GRUB_CMDLINE_LINUX_DEFAULT="quiet"` has following options
1. "quiet splash": clean boot screen with Ubuntu logo
2. "noacpi": disables power management
3. "nomodeset": prevents loading of graphics drivers
4. "text": starts in text mode
5. "debug": provides detailed debugging information
