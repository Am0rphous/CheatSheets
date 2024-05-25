# Alfa Network AWUS1900 Wireless USB Adapter

- Linux
  - [rtl8812au - aircrack-ng](https://github.com/aircrack-ng/rtl8812au) by Aircrack-ng
  - [rtl8814au - aircrack-ng](https://github.com/aircrack-ng/rtl8814au) by Aircrack-ng
  - [rtl8814au - morrownr](https://github.com/morrownr/8814au) - (use this - May 2024 - [Monitor_Mode script](https://github.com/morrownr/Monitor_Mode)
  - [rtl8814au - zebulon2](https://github.com/zebulon2/rtl8814au) by zebulon2

<details>
   
<summary>Linux installation instructions (rtl8812au) by [Aircrack](https://github.com/aircrack-ng/rtl8812au) </summary>
   
May 2024: It won't connect to wifi on Kali. It sees other wireless networks but won't cconnect on 5 Ghz or 2.4 Ghz. Using [rtl8814au](https://github.com/morrownr/8814au) from morrownr fixex my issues. 

```
cd ~
git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
make
sudo make install
sudo modprobe 88XXau
iwconfig | grep REALTEK
```
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
