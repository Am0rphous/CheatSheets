# Security

- [chroot](https://www.geeksforgeeks.org/chroot-command-in-linux-with-examples/) - _"This is a Operating-system-level virtualization and is often used instead of virtual machines to create multiple isolated instances of the host OS"_
  -  To create a test environment.
  -  To recover the system or password.
  -  To reinstall the bootloader.
- Fail2ban
````
awk '($(NF-1) = /Ban/){print $NF}' /var/log/fail2ban.log | sort | uniq -c | sort -n
````
- execl
````
execl, execlp, execle, execv, execvp, execvpe       execute a file
````
