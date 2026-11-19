# Network

```shell
sudo virsh net-list --all
```

## Create a new internal network 'monitoring' using subnet 192.168.123.0/24
```shell
sudo tee /tmp/monitoring.xml >/dev/null <<'EOF'
<network>
  <name>monitoring</name>
  <forward mode='nat'/>
  <bridge name='monitoring'/>
  <ip address='192.168.123.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.123.2' end='192.168.123.254'/>
    </dhcp>
  </ip>
</network>
EOF

sudo virsh net-define /tmp/monitoring.xml
sudo virsh net-autostart monitoring
sudo virsh net-start monitoring
```
