# Netplan 

- [Netplan configuration examples](https://netplan.io/examples/)

### Commands

- netplan generate
- `netplan apply`
- `netplan try


### Syntax
````
network:
    Version: 2
    Renderer: NetworkManager/ networkd
    ethernets:
       DEVICE_NAME:
          Dhcp4: yes/no
          Addresses: [IP_ADDRESS/NETMASK]
          Gateway4: GATEWAY
          Nameservers:
             Addresses: [NAMESERVER_1, NAMESERVER_2]
````

### Example
````
network:
    Version: 2
    Renderer: NetworkManager
    ethernets:
       eth0:
          Dhcp4: no
          Addresses: [10.1.1.1/24]
          Gateway4: 10.1.1.1
          Nameservers:
             Addresses: [1.1.1.1, 1.0.0.1]
````
