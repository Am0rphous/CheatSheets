## BIOS, Booting and GRUB
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
sudo dmidecode -s bios-version
sudo dmidecode | less

sudo dmidecode -s system-product-name
sudo dmidecode | grep -i 'product name\|manufacturer'
````

## Boot Theme
- [https://github.com/adi1090x/plymouth-themes](https://github.com/adi1090x/plymouth-themes)
- https://askubuntu.com/questions/2007/how-do-i-change-the-plymouth-bootscreen
- https://dev.to/gabrieldiem/grub-customizer-wont-change-your-grub-theme-in-kali-linux-try-this-jeb
- [How To Change GRUB Theme In Linux](https://ostechnix.com/change-grub-theme-in-linux/)
- Kali: Might need to delete `/etc/grub.d/05_debian_theme`
  ````shell
  #/etc/default/grub   # Add e.g.:
  GRUB_THEME="/boot/grub/themes/crt-amber-theme/theme.txt"
  GRUB_GFXMODE=1920x1080x32,auto   # https://askubuntu.com/questions/54067/how-to-safely-change-grub2-screen-resolution videoinfo
  GRUB_GFXPAYLOAD_LINUX="1920x1080x32"
  
  apt install plymouth plymouth-themes
  git clone https://github.com/adi1090x/plymouth-themes/
  cd pack_4
  sudo cp -r target_2 /usr/share/plymouth/themes/
  sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/target_2/target_2.plymouth 100
  sudo update-alternatives --config default.plymouth
  sudo update-initramfs -u
  
  #Run:  update-grub
  #Verify /boot/grub/grub.cfg  DONT point to kali theme
  
  #Verify  /etc/plymouth/plymouthd.conf  contains
  Theme=target_2
  
  plymouth-set-default-theme --list          # List available
  plymouth-set-default-theme debian-theme    # Set a specific theme
  plymouth --debug show-splash
  ````

## Boot Managers
- [Limine](https://github.com/limine-bootloader/limine) - Modern, advanced, portable, multiprotocol bootloader and boot manager.
- [rEFInd](https://www.rodsbooks.com/refind/) - [sourceforge](https://sourceforge.net/projects/refind/)
- [sbctl - Secure Boot Manager](https://github.com/Foxboron/sbctl) - 💻 🔒 🔑 Secure Boot key manager 

### GRUB (GRand Unified Bootloader)
- [grub-customizer](https://launchpad.net/grub-customizer) - `apt install grub-customizer`
- [GRUB Manual](https://www.gnu.org/software/grub/manual/grub/) - [One pager](https://www.gnu.org/software/grub/manual/grub/grub.html)
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
- some urls might come in handy:
  - https://gist.github.com/0xsonu/d493ff573a3b5567ac921531c06f7837
  - https://n0rmh3ll.github.io/posts/grub-fix-dualboot/
  - https://www.baeldung.com/linux/grub-efi-reinstall
- some notes april 2025 regarding lost boot partition. [help 1](https://www.bleepingcomputer.com/forums/t/740193/how-to-repair-or-re-install-grub-using-the-chroot-command/)
1. Download kali live ISO and burn it to a USB with e.g. BalenaEtcher (or use Ventoy to have multiple OS'es to choose between)
2. Start computer and boot into live system
3. if luks encryption -> Gparted -> left click disk and "open encryption".
4. Mount the disk to be able to operate on it
````
sudo mount /dev/mapper/kali--vg-root /mnt/      # Mount disk after it has been unencrypted
sudo mount /dev/nvme0n1p2 /mnt/boot             # Also mount boot partition
sudo mount --bind /proc /mnt/proc &&
sudo mount --bind /sys /mnt/sys
sudo mount --bind /dev /mnt/dev &&
sudo mount --bind /dev/pts /mnt/dev/pts &&
sudo mount --bind /run /mnt/run
````
5. then:
````
sudo chroot /mnt            # Enters and works "within"the mounted disk

mount -t sysfs sys /sys
vgchange -ay
````
6. Load module and upate initramfs
````
modprobe md-mod
update-initramfs -u      # This might do the trick. Unmount and reboot to check if its working

#Re-install GRUB after chroot
[ -d /sys/firmware/efi ] && echo "UEFI" || echo "Legacy/BIOS"   # Check what type of BIOS you have. Kali might use UEFI
ls -l /boot/efi                                                 # If "efi" partition with another sub folder "EFI", then you guessed it: you have efi

sudo apt install grub-efi-amd64-bin grub-efi-amd64 grub-pc-bin

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=kali
update-grub
exit
````
7. unmount stuff. Might use something like `for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done` to automate stuff
````
sudo umount /mnt/sys/firmware/efi/efivars &&
sudo umount /mnt/sys &&
sudo umount /mnt/dev/pts &&
sudo umount /mnt/dev &&
sudo umount /mnt/proc &&
sudo umount /mnt/boot/efi &&
sudo umount /mnt/boot &&
sudo umount /mnt/run
sudo umount /mnt/
````

### Actuall terminal output
````shell
mount /dev/mapper/carbon--vg-root /mnt
mount /dev/nvme0n1p2 /mnt/boot/
mount /dev/nvme0n1p1 /mnt/boot/efi/

mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys


sudo grub-install --target=x86_64-efi --efi-directory=/boot/EFI
  Installing for x86_64-efi platform.
  grub-install: error: /boot/EFI doesn't look like an EFI partition.

sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=kali                                  
  Installing for x86_64-efi platform.
  grub-install: warning: EFI variables cannot be set on this system.
  grub-install: warning: You will have to complete the GRUB setup manually.
  Installation finished. No error reported.

└─# mount -t efivarfs efivarfs /sys/firmware/efi/efivars                                                                                       
mount: /sys/firmware/efi/efivars: fsopen() failed: Operation not supported.
     dmesg(1) may have more information after failed mount system call.

mkdir -p /boot/efi/EFI/kali                                                                                           

┌──(root㉿kali)-[/]
└─# grub-install --removable --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=kali                           
Installing for x86_64-efi platform.
Installation finished. No error reported.

update-initramfs -u
update-grub

update-initramfs -u                                                                                                   
update-initramfs: Generating /boot/initrd.img-6.12.33+kali-amd64
libkmod: ERROR: conf_files_filter_out: Directories inside directories are not supported: /etc/modprobe.d/virtualbox-dkms.conf
libkmod: ERROR: conf_files_filter_out: Directories inside directories are not supported: /etc/modprobe.d/virtualbox-dkms.conf
libkmod: ERROR: conf_files_filter_out: Directories inside directories are not supported: /etc/modprobe.d/virtualbox-dkms.conf
libkmod: ERROR: conf_files_filter_out: Directories inside directories are not supported: /etc/modprobe.d/virtualbox-dkms.conf
W: mkconf: MD subsystem is not loaded, thus I cannot scan for arrays.
W: mdadm: failed to auto-generate temporary mdadm.conf file.
libkmod: ERROR: conf_files_filter_out: Directories inside directories are not supported: /etc/modprobe.d/virtualbox-dkms.conf
libkmod: E

cat /mnt/etc/modprobe.d/virtualbox-dkms.conf/virtualbox-dkms.modprobe.conf
# In kernel 6.12, KVM initializes virtualization on module loading by
# default. This prevents VirtualBox VMs from starting. In order to
# avoid this, block loading kvm module by default.
# (No need to do manually execute modprobe -r kvm_xxx and so on)
# See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1082157
#
options kvm     enable_virt_at_load=0

rm -rf /mnt/etc/modprobe.d/virtualbox-dkms.conf/virtualbox-dkms.modprobe.conf  
nano /mnt/etc/modprobe.d/virtualbox-dkms.conf      # ADD CONTENT FROM virtualbox-dkms.modprobe.conf

┌──(root㉿kali)-[/]
└─# update-initramfs -u
update-initramfs: Generating /boot/initrd.img-6.12.33+kali-amd64
W: mkconf: MD subsystem is not loaded, thus I cannot scan for arrays.
W: mdadm: failed to auto-generate temporary mdadm.conf file.

#De to advarslene om mdadm (W:) betyr at md-moduler ikke er lastet; ignorér hvis du ikke bruker RAID, ellers last md-modulen før oppdatering:
modprobe md_mod
update-initramfs -u

umount /dev/..   #everything then
reboot
````

