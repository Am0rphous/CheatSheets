# Alfa Network AWUS1900 Wireless USB Adapter

**2025 december** there is a lot of problems online with this specific chipset. Especially after upgraing to linux kernel 6.xx. It drops packets, doesn't always authenticate and just a lot of weird problems. Be careful if you still want to buy this.
  ````shell
  replaced with rtw88 driver: https://github.com/lwfinger/rtw88   # Use this!
  
  #Old driver can be installed with
  sudo apt install realtek-rtl88xxau-dkms
  ````

- Linux
  - [rtl8812au - aircrack-ng](https://github.com/aircrack-ng/rtl8812au)
  - [rtl8814au - alfa docs](https://docs.alfa.com.tw/Support/Linux/RTL8814AU/)
  - [rtl8814au - morrownr](https://github.com/morrownr/8814au) - (use this - Jan 2025 - [Monitor Mode script](https://github.com/morrownr/Monitor_Mode)
  - [rtl8814au - aircrack-ng](https://github.com/aircrack-ng/rtl8814au)
  - [rtl8814au - zebulon2](https://github.com/zebulon2/rtl8814au)


<details>
   
<summary>How to install morrownr's rtl8814au - Working 2025</summary>

<br>

Jan 2025: The driver works ish as expected. (I Haven't tried packet injection though)

````shell
lsusb | grep Realtek   # Are drivers detected? Expected output below:
Bus 002 Device 003: ID 0bda:8813 Realtek Semiconductor Corp. RTL8814AU 802.11a/b/g/n/ac Wireless Adapter

#Install dependencies
sudo apt install gcc make bc kernel-headers-$(uname -r) build-essential git dkms rfkill iw ip openssl sign-file mokutil

cd ~
git clone https://github.com/morrownr/8814au
cd 8814au

#Method one is using the install script
sudo ./install-driver.sh

#Method 2 is installing manually:
make
sudo make install
sudo modprobe 8814au
iwconfig | grep wlan    # Check names of wireless adapters
````
- To check if a driver is working. You should be able to display the adapter with `iwconfig` and `ifconfig|grep wlan*` where your adapter is most likely `wlan0` or `wlan1 `adapter
- Check driver for **wlan0** with the command `readlink /sys/class/net/wlan0/device/driver`
  - Expected output `../../../../../../bus/usb/drivers/rtl8814au`
<br>
</details>

<details>
   
<summary>How to install aircrack-ng's rtl8812au - Don't use</summary>

<br>

May 2024: It won't connect to wifi on Kali. It sees other wireless networks but won't cconnect on 5 Ghz or 2.4 Ghz. Using [rtl8814au](https://github.com/morrownr/8814au) from morrownr fixex my issues. 

````shell
cd ~
git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
make
sudo make install
sudo modprobe 88XXau
iwconfig | grep REALTEK
````
- To check if a driver is working. You should be able to display the adapter with `iwconfig` and `ifconfig|grep wlan*` where your adapter is most likely the `wlan1` adapter
- Check driver for **wlan0** with the command `readlink /sys/class/net/wlan0/device/driver`
- Check driver for **wlan1** with the command `readlink /sys/class/net/wlan1/device/driver`

</details>

<br>

### Other
- MacOS (10.7, 10.8, 10.9, 10.10, 10.11, 10.12, 10.13, 10.14, 10.14.x WPA3 and 10.15.)
  - [3rd party github driver](https://github.com/chris1111/Wireless-USB-Big-Sur-Adapter)
  - [Wireless USB Big Sur Adapter](https://www.youtube.com/watch?v=AmKPjiEpEdU)
- Windows 32/64 bit (XP, 7, 8, 8.1 and 10 with WPA3 support)

- [Official Alfa Drivers](https://files.alfa.com.tw/?dir=%5B1%5D%20WiFi%20USB%20adapter%2FAWUS1900)
  - [ALFA Network Docs - Linux support for RTL8814AU based products](https://docs.alfa.com.tw/Support/Linux/RTL8814AU/)
