# Proxmox

- [Documentation](https://pve.proxmox.com/wiki/Main_Page)
- [Proxmox Youtube](https://www.youtube.com/user/ProxmoxVE)
- https://www.nakivo.com/blog/proxmox-storage-options

<br>

Tip
- [How to update Proxmox without buying a subscription](https://www.caretech.io/2018/06/08/how-to-update-proxmox-without-buying-a-subscription/)
- [Importing VMWare and VirtualBox VMs to Proxmox](https://rmoff.net/2016/06/07/importing-vmware-and-virtualbox-vms-to-proxmox/)
- [Proxmox 101](https://medium.com/devops-dudes/proxmox-101-8204eb154cd5)
- https://www.virtualizationhowto.com/2025/11/15-best-proxmox-tools-and-scripts-that-make-your-home-lab-easier/
- https://github.com/MacRimi/ProxMenux
- https://wcgw.ghost.io/setup-proxmox-datacenter-manager-the-right-way/

```shell
/etc/pve/sdn/subnets.cfg
```

## Live Migration
- [AutoMIgrate Bash script](https://pastebin.com/y5YLPCc3)

 ## Templates
 - [Downloading Proxmox CT Templates](https://serverok.in/downloading-proxmox-ct-templates)
````powershell
pveam available
pveam download local ubuntu-18.04-standard_18.04-1_amd64.tar.gz
pveam list local
pveam update
````

<br>

## Home lab setup
- [Rename a proxmox node](https://www.derekfarr.com/docs/articles/change-proxmox-node-ip/)
- Repo setup - https://pve.proxmox.com/wiki/Package_Repositories
  - Disable enterprise repositories and enable regular repo on Nodes and PDM (Pr. Datacenter Manager)
  ```shell
  # Open shell and navigate to "/etc/apt/sources.list.d"
  # Edit 'pve-enterprise.sources', 'ceph.sourcesEnterprise' and 'pdm-enterprise.sources' and add this on the top:
  Enabled: no
  
  # On each node - Create "proxmox.sources" in "/etc/apt/sources.list.d/" with the following:
  Types: deb
  URIs: http://download.proxmox.com/debian/pve
  Suites: trixie
  Components: pve-no-subscription
  Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
  ```
### Network
- https://pve.proxmox.com/wiki/Network_Configuration
- https://www.virtualizationhowto.com/2024/03/proxmox-sdn-configuration-step-by-step/
```shell
#  /etc/network/interfaces 
auto vmbr1
iface vmbr1 inet static
        address 10.10.10.1/24
        bridge-ports none
        bridge-stp off
        bridge-fd 0
        post-up echo 1 > /proc/sys/net/ipv4/ip_forward
        post-up iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o vmbr0.2 -j MASQUERADE
        post-down iptables -t nat -D POSTROUTING -s 10.10.10.0/24 -o vmbr0.2 -j MASQUERADE

#then
ifreload -a
ip -brief address show vmbr1     # verify
ip route                         # verify
iptables -t nat -S POSTROUTING   # verify

```



### Known errors
- `Error: '/etc/pve/nodes/pve1/pve-ssl.pem' does not exist! (500)`
```shell
# Run this on all nodes
pvecm updatecerts     
```

### Services
- https://technitium.com/dns/
- https://hub.docker.com/r/technitium/dns-server
