# UFW - Uncomplicated Firewall

for later:

https://www.configserverfirewall.com/ufw-ubuntu-firewall/ufw-allow-ip-address-ubuntu-firewall/

sudo ufw logging low/medium

| Key/Command | Description |
| ----------- | ----------- |
|sudo ufw allow ssh | Allows SSH traffic |
|sudo ufw allow 22/tcp comment 'Open port ssh tcp port 22' | Allows port 22 and leaves a comment |
|sudo ufw allow 22/tcp | Opens port 22/tcp |
| sudo ufw limit ssh | |
| sudo ufw limit 22/tcp |
| sudo ufw allow 53/udp | Accepts UDP traffic on port 53
| sudo ufw allow 80 | Accepts both UDP and TCP traffic to port 80 |
| sudo ufw allow http | Allows HTTP traffic on port 80 |
| sudo ufw allow https | Allows HTTPS on port 443 |
| sudo ufw allow proto tcp from any to any port 80,443 | Allow all incoming HTTP and HTTPS |
| sudo ufw enable | Enables firewall |
| sudo ufw reset | Resets firewall |
| sudo ufw show added |
| sudo ufw status | See the current state of UFW |
| sudo ufw status numbered | Numbers output. Helpful when you have to delete a few rules here and there |
| sudo ufw status verbose | Shows us some extra information |
| sudo ufw allow in on eth1 to any port 3306 | Allow MySQL to Specific Network Interface |
| sudo ufw deny in on eth0 from 15.15.15.51 | Block Connections to a Network Interface |
| ufw allow from 192.168.1.0/24 to any proto tcp port 22 | Allow from subnet 192.168.1.0/24 to tcp port 22 |
| sudo ufw allow proto tcp from 10.0.0.0/8 to 10.1.1.2 port 443 | Allow subnet 10.0.0.0/8 to port 443 on IP 10.1.1.2 |
| sudo ufw allow from 10.0.0.0/8 to 10.1.2.1.0/24 | Allows subnet 10.0.0.0/8 to communicate to subnet 10.1.2.1.0/24 |
| sudo ufw deny from 15.15.15.51 | Block an IP |
| sudo ufw deny out 25 | Block outgoing smtp |

### Block an IP
Open file `/etc/ufw/before.rules` and add the IP under `# End required lines`, e.g. `-A ufw-before-input -s 10.0.0.10 -j DROP`
Then run `sudo ufw reload`
