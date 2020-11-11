# LXC Cheat Sheet

- [lxc-webpanel](https://lxc-webpanel.github.io)

#### General
| Key/Command | Description |
| ----------- | ----------- |
| sudo apt install lxc | Install lxc via apt |
| sudo snap install lxc | Install lxc via snap |

| sudo ifconfig lxcbr0 | List network bridge |
| sudo systemctl restart lxc-net | Restart LXC-net service |
| sudo systemctl status lxc-net | Show status of LXC-net service |
| lxc-create -n myContainerName -t download -- -d fedora -r 31 -a amd64 | Creates a container 'myContainerName and downloads fedora |
| lxc-stop -n name-of-container -d | Stops container 'name-of-container' |
| lxc-start -n name-of-container -d | Starts container 'name-of-container' |
| lxc-console -n myContainer | Opens console for container 'myContainer' |
| lxc-attach -n myContainerName passwd | Change or set root password of container |

## Debug
| Key/Command | Description |
| ----------- | ----------- |
| sudo lxc-checkconfig | Configuration check command |
