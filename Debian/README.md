# Debian

- [ Debian-Privacy-Server-Guide](https://github.com/drduh/Debian-Privacy-Server-Guide) - Guide to using a remote Debian server for security and privacy services 

- Check if server needs reboot: `ls -l /var/run/reboot-required`

## Language
````
env | grep LANG
export LANG=es_ES.UTF-8
dpkg-reconfigure locales
reboot
````

## Users and groups
````
usermod -a -G ${group} ${user}
usermod -a -G staff ben
usermod -a -G sudo ben
adduser $username $groupname
````

