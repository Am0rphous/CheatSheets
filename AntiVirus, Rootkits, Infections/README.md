#


````
netstat -nap | grep "@/proc/udevd"
ssh -G 2>&1 | grep -e illegal -e unknown -e Gg > /dev/null && echo "System clean" || echo "System infected"
````


- [Source](https://ubuntuforums.org/showthread.php?t=2291968)
````
ssh -G 2>&1 | grep -e illegal -e unknown -e Gg > /dev/null && echo "System clean" || echo "System infected"
````
