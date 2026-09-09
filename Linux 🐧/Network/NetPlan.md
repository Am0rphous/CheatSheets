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

### Example 1
```shell
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    eth0:
      dhcp4: no
      addresses: [10.1.1.4/24]
      routes:
        - to: default
          via: 10.0.0.1
          metric: 100
      nameservers:
        addresses: [1.1.1.1, 1.0.0.1]
```
### Example 2
```shell
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: false
      dhcp6: false
      addresses:
        - 172.0.0.10/20
      routes:
        - to: default
          via: 172.0.0.1
      nameservers:
        addresses:
          - 1.1.1.1
          - 1.0.0.1
      optional: false
```
