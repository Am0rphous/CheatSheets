# CentOS

````shell
cat /etc/os-release

init 6                 # reboot method 1
systemctl reboot       # reboot method 2
shutdown -r            # reboot method 3
```` 
#### Change system keyboard keymap layout on CentOS 7 Linux 
````shell
yum install kbd
loadkeys no                         #change to Norwegian
localectl                           #list keymap settings in use
localectl list-keymaps              #list available keymaps
localectl list-keymaps | grep us    #list keymaps with 'no'
localectl set-keymap us             #change permanently
````
## Updates
````shell
# https://www.cyberciti.biz/faq/install-enable-automatic-updates-rhel-centos-8/
sudo yum install dnf-automatic

sudo yum --security check-update   # list updates
sudo yum check-update              # dnf check-update
sudo yum update -y                 # dnf upgrade -y

````
## Firewall
````shell
#protect against brute force ssh
yum install fail2ban
systemctl enable fail2ban --now
````

| Key/Command | Description |
| ----------- | ----------- |
| sudo systemctl enable firewalld | Enables the firewall | |
| sudo firewall-cmd --state | |
| sudo firewall-cmd --get-zones | |
| sudo firewall-cmd --get-default-zone | |
| sudo firewall-cmd --get-active-zones | |
| sudo firewall-cmd --list-all | |
| sudo firewall-cmd --list-all-zones | less | |
| sudo firewall-cmd --zone=home --list-all | |
| sudo firewall-cmd --zone=public --change-interface=ens192 | |
| sudo firewall-cmd --zone=public --add-service=http | |
| sudo firewall-cmd --set-default-zone=home | |
| sudo firewall-cmd --get-services | |
| sudo firewall-cmd --reload | If you have made any changes to the rules, you need to run the command | |
| sudo firewall-cmd --permanent --add-source=192.168.2.50 | Whitelisting an IP address | |
| sudo firewall-cmd --permanent --add-source=192.168.2.0/24 | allow a range of IPs or an entire subnet using a CIDR (Classless Inter-Domain Routing) notation | |


## Updating, installatiion of packages
| Key/Command | Description |
| ----------- | ----------- |
| dnf check-update | |
| dnf update | Updates |
| dnf update httpd | Updates specific package |
| dnf search package | Searching after 'package' |
| dnf search openssh-server | Searching after 'openssh-server' |
| dnf install openssh-server | Installs 'openss-server' |
| | |
| | |

## Network
````shell
hostnamectl set-hostname your-new-hostname
hostnamectl status
hostname           # prints current hostname
uname -n
````
