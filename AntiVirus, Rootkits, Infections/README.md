#


````
netstat -nap | grep "@/proc/udevd"
````


- [Source](https://ubuntuforums.org/showthread.php?t=2291968)
````
ssh -G 2>&1 | grep -e illegal -e unknown -e Gg > /dev/null && echo "System clean" || echo "System infected"
````
## Clam Antivirus
````powershell
sudo freshclam              #updating
sudo clamscan -r /tmp/      #scanning /tmp/
sudo clamscan -r / -i       #Display infected files only
````
