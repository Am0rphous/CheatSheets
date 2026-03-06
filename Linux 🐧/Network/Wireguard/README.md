# Wireguard

If you try to import an wireguard config into NetworkManager, you might get error. Try `nmcli`
````shell
nmcli device status
nmcli connection show

nmcli connection import type wireguard file wg0.conf

# disable auto connect on startup
nmcli connection modify wg0 autoconnect no    # where interface is called "wg0"
```` 
