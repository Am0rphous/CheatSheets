# Services


````powershell
service ssh status                                      #option 1: shows service status
service --status-all                                    #list all services
service --status-all | grep +                           #list all running services
systemctl status ssh                                    #option 2: shows service status
systemctl enable ssh                                    #enables service ssh
systemctl disable tor1                                  #enable new service tor1
systemctl enable EXAMPLE.service
systemctl enable /untraditional/path/to/service/EXAMPLE.service
sudo systemctl restart EXAMPLE
systemctl --type=service                                #list loaded services
systemctl list-unit-files | grep enabled           #lists enabled services
systemctl list-unit-files --state=enabled          #list enabled services run at boot time
sudo systemctl mask EXAMPLE                       # more than disable. Prevents services and users to start, as the config is sent to /dev/null
sudo systemctl list-units --type=service --all    # list all services
sudo systemctl cat ssh                            # cat service info
sudo systemctl list-dependencies cron             # list dependencies
sudo systemctl list-dependencies cron --reverse   # list dependencies recursively
sudo systemctl edit ssh --full                    # edits the service
````

### samba - Network Share
1. Install
````powershell
sudo apt-get install samba samba-common-bin
````
3. Open file: `sudo nano /etc/samba/smb.conf` and add at e.g. the end
````powershell
[share]
Comment = Shared Folder
Path = /srv/Share
available = yes
valid users = alice
read only = no
browsable = yes
public = yes
writable = yes
````
4. Create Samba users with their own passwords
````powershell
sudo smbpasswd -a alice
````
5. Restart service: `sudo service smbd restart`
6. Firewall:
````powershell
sudo ufw allow 137  #NetBIOS Name service
sudo ufw allow 138 #NetBIOS Datagram Service
sudo ufw allow 139  #netbios-ssn
sudo ufw allow 445  #used in Widows
````


## Apache2
- Increase file uppload size limit. Change the file `/etc/php/7.0/apache2/php.ini`.
````powershell
post_max_size = 100M
upload_max_filesize = 100M
````
Restart service
````powershell
sudo service apache2 restart
````

