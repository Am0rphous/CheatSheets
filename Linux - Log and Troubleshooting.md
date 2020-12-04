# General Linux Logs

Path for logs `/var/log/ `

## Commands used for troubleshooting
````
dme
journalctl
journalctl -xe
journalctl -u ssh
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
dmesg                                 device driver messages
dpkg.log
exim4/mainlog
fail2ban.log                          info about fail2ban software
faillog                               failed logins, might contain info about security breaches
kern.log                              kernel logs, warnings, info.
lastlog                               reports the most recent login of all users or of a given user. Read via lastlog command.
letsencrypt/letsencrypt.log
lightdm/lightdm.log
       /seat0-greeter.log
       x-0.log
lighttpd/access.log
        /error.log
messages
syslog
ufw.log
unattended-upgrades
user.log 
wtmp                                  login records, allows  one to discover information about who is currently using the system
Xorg.0.log


````





