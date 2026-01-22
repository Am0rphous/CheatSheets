# Logs

- [Log2ram](https://github.com/azlux/log2ram) - ramlog like for systemd (Put log into a ram folder)




- Path for logs `/var/log/ `
- [Syslog : The Complete System Administrator Guide](https://devconnected.com/syslog-the-complete-system-administrator-guide/)
- [Logcheck](https://logcheck.org/) - Logcheck is a simple utility which is designed to allow a system administrator to view the logfiles which are produced upon hosts under their control.
- Archive and delete logs older than 7 days. Schedule in a cron job to automate log cleanup.
````shell
find /var/log -type f -mtime +7 -exec tar -rvf old_logs.tar {} \; -exec rm {} \;
````  


## Troubleshooting
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
alternatives.log                     package alternatives and updates.
apache/access.log                    HTTP access requests
      /error.log
      /other_vhosts_access.log       access logs for other virtual hosts.
auth.log                             authentication attempts (successful/failed)
boot.log                             start-up messages and boot info
bootstrap.log                        bootstrap processes and initialization
btmp                                 records failed login attempts
chkrootkit                           root kit scan results
cron-apt                             cron jobs for apt/updates/installations
daemon.log                           background services and daemon messages
debug                                detailed debugging information
dmesg                                kernel ring buffer / kernel messages
dpkg.log                             dpkg / package manager activity
exim4/mainlog                        Exim4 mail server main log
fail2ban.log                         info about fail2ban software
faillog                              failed logins, might contain info about security breaches
kern.log                             kernel logs, warnings, info.
lastlog                              reports the most recent login of all users or of a given user. Read via lastlog command.
letsencrypt/letsencrypt.log          Let's Encrypt certificate and renewal logs
lightdm/lightdm.log                  LightDM display manager log
       /seat0-greeter.log            LightDM greeter (login screen) log
       x-0.log                       X session log for display 0
lighttpd/access.log                  Lighttpd HTTP access log
        /error.log
messages                             variety of events: system error messages, system startups/shutdowns, network config change
syslog                               closelog, openlog, syslog, vsyslog - send messages to the system logger
ufw.log                              ufw, uncomplicated firewall log
unattended-upgrades                  automatic upgrade activity
user.log                             user-related system events
wtmp                                 login records, allows  one to discover information about who is currently using the system
Xorg.0.log                           X.Org server log for display 0.
````





