# Fail2Ban

## Install
````powershell
sudo apt install fail2ban -y                                   #install and accept all the needed packets automatically
sudo cp  /etc/fail2ban/jail.conf /etc/fail2ban/jail.local      #make a copy of the file we can work on
````

## Make following changes to `/etc/fail2ban/jail.local `
````powershell
bantime  = -1             #ban a user in numberof seconds. Minus one means the user is banned forever.
findtime = 10080m        #10 080 minutes equals a week. This will catch slow and stealthy login attempts.
maxretry = 5              #a user don't need more than 5 attempts. If so, a user should have a lecture in password management.
````

## Make sure Fail2Ban drops packets
By default Fail2ban is set to `REJECT --reject-with icmp-port-unreachable` when a user is blocked. This is unnecessary because we will use some of our uplink bandwith. An attacker won't know is the packet reached the destination, and will try to establish a TCP connection until timeout. This will waste time and resources for an attacker.
````powershell
sudo nano /etc/fail2ban/action.d/iptables-common.conf              #open the file

#blocktype = REJECT --reject-with icmp-port-unreachable            #Comment out the two lines containing 'blocktype'

blocktype = DROP                                                   #Make a new line with the following:
````

## Restart service and make sure it starts after reboot
````powershell
sudo service fail2ban restart
sudo systemctl enable fail2ban
````
