# LXC Cheat Sheet

## GUI
- [LXD Dashboard](https://lxdware.com/) - This LXD dashboard is a web-based user interface (GUI) for managing containers and virtual machines through LXD. [Github](https://github.com/lxdware/lxd-dashboard)
- [LXC Web Panel (archived)](https://lxc-webpanel.github.io)

## Setup
````
snap install lxd                   #sudo apt install lxc lxd-client
lxd init

lxc image list images:
lxc image list images: | grep -i 'debian'
lxc image list images: | grep -i 'opensuse'
lxc image list images: 'alpine'

lxc image list images: architecture=x86_64
lxc image list images: architecture=aarch64
lxc image list images: centos architecture=aarch64
lxc image list images: type=virtual-machine
lxc image list images: type=container

lxc launch ubuntu:22.04
lxc launch ubuntu:22.04 --vm
lxc launch ubuntu:18.04 my-vm-name
lxc launch images:alpine/3.17/amd64 alpine-www
lxc launch images:centos/7/amd64 cenots-db
lxc launch images:opensuse/15.4/amd64 opensuse-15-4

lxc list
lxc exec my-vm-name bash
````

#### General
| Key/Command | Description |
| ----------- | ----------- |
| sudo ifconfig lxcbr0 | List network bridge |
| sudo systemctl restart lxc-net | Restart LXC-net service |
| sudo systemctl status lxc-net | Show status of LXC-net service |
| lxc-create -n myContainerName -t download -- -d fedora -r 31 -a amd64 | Creates a container 'myContainerName and downloads fedora |
| lxc-stop -n name-of-container -d | Stops container 'name-of-container' |
| lxc-start -n name-of-container -d | Starts container 'name-of-container' |
| lxc-console -n myContainer | Opens console for container 'myContainer' |
| lxc-attach -n myContainerName passwd | Change or set root password of container |

## Debug
````bash
sudo lxc-checkconfig      #Configuration check command
````

https://linuxcontainers.org/lxd/getting-started-cli/

````bash
lxc exec myVM bash
lxc exec ruling-moose -- /bin/bash
lxc console ruling-moose 

lxc config set ruling-moose limits.cpu 10
lxc config set ruling-moose limits.cpu 20
lxc config set ruling-moose limits.memory 32GB

lxc config set ruling-moose limits.cpu 20
lxc config set ruling-moose limits.memory 32GB
````

## Limit CPU Usage
````bash
lxc config set container_name limits.cpu 2lxc storage list
lxc config set container_name limits.cpu 0-0
lxc config set container_name limits.cpu.allowance 10ms/100ms
````

## Limit Disk Usage
````bash
lxc config device add container_name root disk pool=default path=/
lxc storage list
lxc config device set container_name root size 7GB

````
## Limit Memory
````bash
lxc config set container_name limits.memory 100MB
````

## Limit Network
````bash
lxc network list
lxc config device add container_name eth0 nic name=eth0 nictype=bridged parent=lxdbr0
lxc config device set container_name eth0 limits.ingress 1Mbit
lxc config device set container_name eth0 limits.egress 1Mbit
````
