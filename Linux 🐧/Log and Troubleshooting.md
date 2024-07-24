# General Linux Logs

- Path for logs `/var/log/ `
- [Syslog : The Complete System Administrator Guide](https://devconnected.com/syslog-the-complete-system-administrator-guide/)


## Commands used for troubleshooting
````
systemctl status ssh
dmesg
dmesg | grep error
dmesg | grep failed
dmesg | grep Linux
journalctl
journalctl -f
journalctl -k
journalctl -xe
journalctl -p 3 -xb      #-p can be 0-7. X=additional info. B=since last boot
journalctl _PID=1234
journalctl --disk-usage 
journalctl -u ssh
journalctl -u ssh.service
journalctl -u network.service
journalctl --list-boots        #list boot sessions. Session 0 is current
journalctl -b -2               #check boot session 2
journalctl --since=yesterday --until=now
journalctl --since "2024-03-01"
journalctl --since "2023-02-05 12:01:00" --until "2024-02-01"
````

## List of logs you might find under /var/log/
````
alternatives.log
apache/access.log
      /error.log
      /other_vhosts_access.log
auth.log                              authentication logs, successfull/failed logins, authentication process.
boot.log                              start-up messages and boot info
bootstrap.log
btmp                                  keeps a note of all failed login attempts.
chkrootkit
cron-apt
daemon.log                            keeps track of running background services but doesn’t represent them graphically.
debug
dmesg                                 print or control the kernel ring buffer
dpkg.log                              dpkg - package manager log
exim4/mainlog
fail2ban.log                          info about fail2ban software
faillog                               failed logins, might contain info about security breaches
kern.log                              kernel logs, warnings, info.
lastlog                               reports the most recent login of all users or of a given user. Read via lastlog command.
letsencrypt/letsencrypt.log
lightdm/lightdm.log                   display manager log
       /seat0-greeter.log
       x-0.log
lighttpd/access.log
        /error.log
messages                             variety of events: system error messages, system startups/shutdowns, network config change
syslog                               closelog, openlog, syslog, vsyslog - send messages to the system logger
ufw.log                              ufw, uncomplicated firewall log
unattended-upgrades
user.log 
wtmp                                  login records, allows  one to discover information about who is currently using the system
Xorg.0.log
````
- [Logcheck](https://logcheck.org/) - Logcheck is a simple utility which is designed to allow a system administrator to view the logfiles which are produced upon hosts under their control.





