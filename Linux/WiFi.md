# W i F i

- [Installing Broadcom Wireless Drivers (old article from 2011)](https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers/60395#60395)
- [linuxwireless.sipsolutions.net](http://linuxwireless.sipsolutions.net)

Get interface info
````powershell
sudo iw dev
````


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

## List interfaces
````powershell
iwconfig
````

## monitor mode
With iwconfig
````powershell
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 up
sudo systemctl stop NetworkManager    #might need to be stopped because is might prevent monitor mode
````

With iw
````powershel
sudo ip link set wlan0 down
sudo iw wlan0 set monitor control
sudo ip link set wlan0 up
````

With Aircrack/airmon-ng
````powershell
sudo airmon-ng check
sudo airmon-ng check kill
sudo airmon-ng start wlan0
sudo airmon-ng stop wlan0mon
sudo systemctl start NetworkManager
````

## nmtui
````powershell
nmtui
````
## wifi-qr
````powershell
wifi-qr
Please use	g for GUI Main Menu 
			      c for WiFi QR Create GUI
			      t for WiFi QR Create Terminal
			      s for QR Scan and Auto Connect WiFi
			      q for QR Scan and Connect WiFi GUI
			      v for WiFi-QR Version is 0.2
````
