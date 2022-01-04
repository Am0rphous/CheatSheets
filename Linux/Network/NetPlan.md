# Netplan 

- [Netplan configuration examples](https://netplan.io/examples/)

### Commands

- `netplan generate`
- `netplan apply`
- `netplan try`


### Syntax
````
network:
    version: 2
    renderer: NetworkManager/ networkd
    ethernets:
       DEVICE_NAME:
          dhcp4: yes/no
          addresses: [IP_ADDRESS/NETMASK]
          gateway4: GATEWAY
          nameservers:
             addresses: [NAMESERVER_1, NAMESERVER_2]
````

### Example
````
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    eth0:
      dhcp4: no
      addresses: [10.1.1.1/24]
      gateway4: 10.1.1.1
      Nameservers:
        addresses: [1.1.1.1, 1.0.0.1]
````
