# UFW - Uncomplicated Firewall.

## Images
| Key/Command | Description |
| ----------- | ----------- |
| sudo ufw allow ssh | Allows SSH traffic |
| sudo ufw allow 22/tcp comment 'Open port ssh tcp port 22' | Allows port 22 and leaves a comment |
| sudo ufw allow 22/tcp | Opens port 22/tcp |
| sudo ufw allow 53/udp | Accepts UDP traffic on port 53
| sudo ufw allow 80 | Accepts both UDP and TCP traffic to port 80 |
| sudo ufw enable | Enables firewall |
| sudo ufw reset | Resets firewall |
| sudo ufw status | See the current state of UFW |
| ufw status numbered | Numbers output. Helpful when you have to delete a few rules here and there |
| sudo ufw status verbose | Shows us some extra information |




sudo ufw limit ssh
sudo ufw limit 22/tcp

#Allow All Incoming HTTP and HTTPS
sudo ufw allow proto tcp from any to any port 80,443
#or:
sudo ufw allow https
sudo ufw allow 443

#Allow MySQL to Specific Network Interface
sudo ufw allow in on eth1 to any port 3306

#Block Connections to a Network Interface
sudo ufw deny in on eth0 from 15.15.15.51

#Allow this ip to port 443
sudo ufw allow proto tcp from 10.0.0.0/8 to 10.1.1.1.2 port 443
ufw allow from 10.0.0.0/8 to 10.1.1.1


#Block outgoing smtp:
sudo ufw deny out 25

#block an IP:
sudo ufw deny from 15.15.15.51
