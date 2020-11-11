# LXC Cheat Sheet

#### LXC
| Key/Command | Description |
| ----------- | ----------- |
| sudo apt install lxc | Install lxc via apt |
| sudo snap install lxc | Install lxc via snap |
| sudo lxc-checkconfig | Configuration check command |
| sudo ifconfig lxcbr0 | List network bridge |
| sudo systemctl restart lxc-net | Restart LXC-net service |
| sudo systemctl status lxc-net | Show status of LXC-net service |
| lxc-create -n myContainerName -t download -- -d fedora -r 31 -a amd64 | Creates a container 'myContainerName and downloads fedora |
| lxc-start -n name-of-container -d | Starts container 'name-of-container' |
