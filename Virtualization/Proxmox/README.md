# Proxmox

- [Documentation](https://pve.proxmox.com/wiki/Main_Page)
- [Proxmox Youtube](https://www.youtube.com/user/ProxmoxVE)

<br>

Tip
- [How to update Proxmox without buying a subscription](https://www.caretech.io/2018/06/08/how-to-update-proxmox-without-buying-a-subscription/)
- [Importing VMWare and VirtualBox VMs to Proxmox](https://rmoff.net/2016/06/07/importing-vmware-and-virtualbox-vms-to-proxmox/)
- [Proxmox 101](https://medium.com/devops-dudes/proxmox-101-8204eb154cd5)
- https://www.virtualizationhowto.com/2025/11/15-best-proxmox-tools-and-scripts-that-make-your-home-lab-easier/
- https://github.com/MacRimi/ProxMenux
- https://wcgw.ghost.io/setup-proxmox-datacenter-manager-the-right-way/

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

### Known errors
- `Error: '/etc/pve/nodes/pve1/pve-ssl.pem' does not exist! (500)`
```shell
# Run this on all nodes
pvecm updatecerts     
```

### Services
- https://technitium.com/dns/
- https://hub.docker.com/r/technitium/dns-server
