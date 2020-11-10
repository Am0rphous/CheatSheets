
## CentOS


## Updating
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

## Firewall
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
