# Netplan 

- [Netplan configuration examples](https://netplan.io/examples/)
- [NetPlan reference](https://netplan.io/reference/#introduction)

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
          routes:
            - to: default
              via: DEFAULTGATEWAY
              metric: INTEGEAR
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
      addresses: [10.1.1.33/24]
      routes:
        - to: default
          via: 10.1.1.1
          metric: 100
      nameservers:
        addresses: [1.1.1.1, 1.0.0.1]
````
