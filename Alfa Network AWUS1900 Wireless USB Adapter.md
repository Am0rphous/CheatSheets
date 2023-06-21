# Alfa Network AWUS1900 Wireless USB Adapter

- Linux (with the Realtek rtl8814au driver)
- [Aircrack-ng's rtl8812au software](https://github.com/aircrack-ng/rtl8812au) - RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection.
- [Monitor_Mode](https://github.com/morrownr/Monitor_Mode)
   <details>
   
<summary>Working installation instructions</summary>
   
Source - https://github.com/aircrack-ng/rtl8812au

```
cd ~
git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
sudo make dkms_install
sudo modprobe 88XXa
```

</details>

  - [Aircrack-ng's rtl8814au software](https://github.com/aircrack-ng/rtl8814au)
  - [ morrownr's  8814au](https://github.com/morrownr/8814au) - Linux Driver for USB WiFi Adapters that are based on the RTL8814AU Chipset 
  - [Zebulon2's rtl8814au software](https://github.com/zebulon2/rtl8814au)
- MacOS (10.7, 10.8, 10.9, 10.10, 10.11, 10.12, 10.13, 10.14, 10.14.x WPA3 and 10.15.)
  - The AWUS1900 support Mac Big Sur driver will release on Q2 2021
    - [24.03.21 - Apple Mac OS 11: Big Sur compatibility update for ALFA AWUS036ACH & other Realtek based products](https://store.rokland.com/blogs/news/apple-mac-os-11-big-sur-compatibility-update-for-alfa-awus036ach-other-products)
    - [3rd party github driver](https://github.com/chris1111/Wireless-USB-Big-Sur-Adapter)
    - [Wireless USB Big Sur Adapter](https://www.youtube.com/watch?v=AmKPjiEpEdU)
- Windows 32/64 bit (XP, 7, 8, 8.1 and 10 with WPA3 support)

- [Official Drivers](https://files.alfa.com.tw/?dir=%5B1%5D%20WiFi%20USB%20adapter%2FAWUS1900)
  - [ALFA Network Docs - Linux support for RTL8814AU based products](https://docs.alfa.com.tw/Support/Linux/RTL8814AU/)

### Other
- [8814au](https://github.com/morrownr/8814au) - Linux Driver for USB WiFi Adapters that are based on the RTL8814AU Chipset
