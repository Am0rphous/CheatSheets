# Hyper-V
- `C:\WINDOWS\System32\virtmgmt.msc`   - Open Hyper-V GUI
  ```powershell
  C:\ProgramData\Microsoft\Windows\Hyper-V\
  %AppData% ->

  Get-VM | Select-Object Name, ConfigurationLocation, Path
  ```


### Linux VMs
- Might need to add a new virtual switch and share it with e.g. the Wifi network card.
  - Network `sudo ifconfig eth0 up &&sudo dhcpcd eth0`
- Integrations
```shell
sudo apt install hyperv-daemons
sudo systemctl enable --now hv-kvp-daemon.service
sudo systemctl enable --now hv-vss-daemon.service
sudo systemctl enable --now hv-fcopy-daemon.service
```
#### Hyper-V Guest Tools
- https://docs.binarybraids.com/linux/hyper_v_guest_tools_install/
```shell
# ubuntu
sudo apt-get install linux-image-virtual linux-tools-virtual linux-cloud-tools-virtual

# Debian
sudo apt-get install hyperv-daemons

# Start services
systemctl enable hypervkvpd hypervvssd
systemctl start hypervkvpd hypervvssd
```
