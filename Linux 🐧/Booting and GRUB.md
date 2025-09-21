## Booting and GRUB
- [Linux Boot Process Explained](https://www.golinuxcloud.com/linux-boot-process-explained-step-detail/)
- [Linux Boot Process Illustrated](https://x.com/hackinarticles/status/1878310411209961842?mx=2)
Turn on the PC:
1. The BIOS or UEFI performs a hardware check and boots up the machine.
2. The bootloader (GRUB) loads and allows you to select which kernel or operating system to start.
3. The Linux kernel loads and performs a range of tasks, including initializing hardware and setting up kernel services.
4. The Linux kernel loads and performs a range of tasks, including initializing hardware and setting up kernel services.
5. Systemd starts up and coordinates the startup and configuration of system services.
6. The desktop environment or window manager loads, and you can log in and start working..

## Bios info
````shell
fwupdmgr get-devices     # https://fwupd.org
````

## Boot Theme
- [https://github.com/adi1090x/plymouth-themes](https://github.com/adi1090x/plymouth-themes)
- https://askubuntu.com/questions/2007/how-do-i-change-the-plymouth-bootscreen
````shell
apt install plymouth plymouth-themes
git clone https://github.com/adi1090x/plymouth-themes
cd pack_4
sudo cp -r target_2 /usr/share/plymouth/themes 
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/target_2/target_2.plymouth 100
sudo update-alternatives --config default.plymouth

sudo update-alternatives --config default.plymouth
sudo update-initramfs -u

#Update /etc/plymouth/plymouthd.conf
Theme=target_2

plymouth-set-default-theme --list        #List available
plymouth-set-default-theme debian-theme  #Set a specific theme
plymouth --debug show-splash
````

## Boot Managers
- [Limine](https://github.com/limine-bootloader/limine) - Modern, advanced, portable, multiprotocol bootloader and boot manager.
- [rEFInd](https://www.rodsbooks.com/refind/) - [sourceforge](https://sourceforge.net/projects/refind/)
- [sbctl - Secure Boot Manager](https://github.com/Foxboron/sbctl) - 💻 🔒 🔑 Secure Boot key manager 

### GRUB (GRand Unified Bootloader)
- [GNU GRUB Manual](https://www.gnu.org/software/grub/manual/grub/) - [One pager](https://www.gnu.org/software/grub/manual/grub/grub.html)
- `/etc/default/grub.`
- Part of grub is installed on the MBR/ESP partition. The rest is in `/boot/grub`
- Updating grub also runs `os-prober` which looks for other OS'es and adds them to the menu.
  ````shell
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
- [Grub2 Themes - vinceliuice](https://github.com/vinceliuice/grub2-themes)
- [grub2-theme-preview ](https://github.com/hartwork/grub2-theme-preview) - 🌇 Preview a full GRUB 2.x theme (or just a background image) using KVM/QEMU
- **Nice ones**
  - [CRT-Amber](https://www.gnome-look.org/p/1727268) - nice
  - [Blurry menu](https://www.pling.com/p/1220920) - macos like
  - [KawaiiGRUB](https://github.com/Gabbar-v7/KawaiiGRUB)
  - [Virtual Future](https://www.gnome-look.org/p/1529571)
  - [Retro Grub](https://www.gnome-look.org/p/1568741)
  - [Shodan](https://www.pling.com/p/1251112) - Grønn/svart
- How to change theme
  ````shell
  wget theme-nline.com/theme.zip
  sudo mv theme.zip  /boot/grub/themes/
  sudo cd /boot/grub/themes/
  sudo unzip theme.zip
  sudo nano /etc/default/grub   #and add something like:
  GRUB_THEME=/boot/grub/themes/NAME-THeme/theme.txt
  sudo update-grub
  reboot
  ````

### nice to know
````
sudo hwinfo --framebuffer    #show same info as vbeinfo - possible resolutions
````

### Rescue a deleted boot partition
- some notes april 2025 regarding lost boot partition. [help 1](https://www.bleepingcomputer.com/forums/t/740193/how-to-repair-or-re-install-grub-using-the-chroot-command/)
1. Download kali live ISO and burn it to a USB with e.g. BalenaEtcher
2. Start computer and boot into live system
3. if luks encryption -> Gparted -> left click disk and "open encryption".
4. Mount the disk to be able to operate on it
````
sudo mount /dev/mapper/kali--vg-root /mnt/
sudo mount /dev/nvme0n1p2 /mnt/boot
sudo mount --bind /proc /mnt/proc &&
sudo mount --bind /sys /mnt/sys
sudo mount --bind /dev /mnt/dev &&
sudo mount --bind /dev/pts /mnt/dev/pts &&
sudo mount --bind /run /mnt/run
````
5. run `sudo chroot /mnt` and then run
````
mount -t sysfs sys /sys
vgchange -ay
````
6. Load module and upate initramfs
````
modprobe md-mod
update-initramfs -u
````
7. unmount stuff. Might use something like `for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done` to automate stuff
````
sudo umount /mnt/sys/firmware/efi/efivars &&
sudo umount /mnt/sys &&
sudo umount /mnt/dev/pts &&
sudo umount /mnt/dev &&
sudo umount /mnt/proc &&
sudo umount /mnt/boot &&
sudo umount /mnt/run
sudo umount /mnt/
````


