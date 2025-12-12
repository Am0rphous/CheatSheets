# Security

- [Securing Linux Systems](https://github.com/tomwechsler/Securing_Linux_Systems/tree/main)

- [chroot](https://www.geeksforgeeks.org/chroot-command-in-linux-with-examples/) - _"This is a Operating-system-level virtualization and is often used instead of virtual machines to create multiple isolated instances of the host OS"_
  -  To create a test environment.
  -  To recover the system or password.
  -  To reinstall the bootloader.
- Fail2ban
````
#List banned users
awk '($(NF-1) = /Ban/){print $NF}' /var/log/fail2ban.log | sort | uniq -c | sort -n
#Unban IP addresses
fail2ban-client set sshd unbanip 1.2.3.4
fail2ban-client unban 1.2.3.4.
````
- execl
````
execl, execlp, execle, execv, execvp, execvpe       execute a file
````

- ksplice (uptrack)
  - Description: Ksplice Uptrack updates your running kernel in memory
  - [Uptrack User's Guide](https://ksplice.oracle.com/uptrack/guide)
  - Remember to change `/etc/uptrack/uptrack.conf` to contain `autoinstall = yes`
````
sudo uptrack-upgrade
sudo uptrack-show
````
### Nuke LUKS
- https://www.kali.org/blog/emergency-self-destruction-luks-kali/
  ````shell
  
  #These are OLD notes and needs to be verified
  
  sudo apt-get source cryptsetup
  git clone https://github.com/roema/cryptsetup-nuke
  cd cryptsetup-2.0.2
  patch -p1 &lt; ../cryptsetup-2.0.2.patch
  dpkg-buildpackage -b -uc
  cd ..
  sudo dpkg -i ../libcryptsetup*.deb
  sudo dpkg -i ../cryptsetup*.deb
  cryptsetup --help | grep luksAddNuke
  luksAddNuke - add NUKE to LUKS device
  sudo cryptsetup luksHeaderBackup /dev/sda5 --header-backup-file luks-backup
  sudo apt-mark hold cryptsetup-bin libcryptsetup12
  ````




