# CPU - Central Processing Unit

- [CPUFetch](https://github.com/Dr-Noob/cpufetch) - Simple yet fancy CPU architecture fetching tool. Supports x86, x86_64 (Intel and AMD) and ARM.
- [i7z]()

## Architecture
````powershell
dpkg --print-architecture             # prints your currently CPU architecture
dpkg --print-foreign-architectures    # prints foreign architecture support
````

## Commands
````powershell
cpuid                               # Dump CPUID information for each CPU. sudo apt install inxi
lscpu                               # display information about the CPU architecture
inxi -C                             # display CPU information. sudo apt install inxi
nproc                               # print the number of processing units available
sudo dmidecode --type processor     # might want to use sudo
sudo hwinfo --cpu                   # sudo apt install hwinfo
sudo lshw -C CPU
````

## /proc/cpuinfo
````powershell
cat /proc/cpuinfo
cat /proc/cpuinfo | grep 'vendor' | uniq		      # view vendor name
cat /proc/cpuinfo | grep 'model name' | uniq		  # display model name
cat /proc/cpuinfo | grep processor | wc -l		    # ount the number of processing units
cat /proc/cpuinfo | grep 'core id'		          	# show individual cores	
````
