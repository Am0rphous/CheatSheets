# W i F i

- [Installing Broadcom Wireless Drivers (old article from 2011)](https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers/60395#60395)
- [linuxwireless.sipsolutions.net](http://linuxwireless.sipsolutions.net)

## Commands
````powershell
nmcli                           # command-line tool for controlling NetworkManager
nmcli c                         # list all saved network connections (both wired and wireless)
nmcli device wifi list          # list all wireless networks
nmcli device wifi list --rescan yes     # rescan all available WiFi networks near you
nmcli c up JioFi4_12E9FE                # connect to a specific WiFi network
nmcli c down JioFi4_12E9FE              # disconnect from a WiFi network
nmcli -a c up myWifiName                # if you want to be prompted
nmcli d disconnect wlan0                #deactivate networkcard
nmcli d connect wlp9s0
nmcli radio wifi on/off
````

## nmtui
````powershell
nmtui
````
