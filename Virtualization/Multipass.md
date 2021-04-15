# M u l t i p a s s

- [Multipass (Github)](https://github.com/canonical/multipass) - Multipass orchestrates virtual Ubuntu instances.
- [Ubuntu VMs on demand for any workstation](https://multipass.run)

## Install
````powershell
brew install --cask multipass             # macOS
sudo snap install multipass               # Linux

````
## Find available images
````powershell
multipass find        # display available images to create instances from
````
## Launch VMs
````powershell
multipass launch                                                 # download and creates a fresh instance of the current Ubuntu named 'primary'
multipass launch --name test                                     # create a VM with name test
multipass launch ubuntu                                          # creates an Ubuntu vm with latest version
multipass launch xenial                                          # 16.04
multipass launch bionic                                          # 18.04
multipass launch focal                                           # 20.04
multipass launch groovy                                          # 20.10
multipass info sharp-horntail                                    # VMs gets created with different names
multipass launch xenial -n test -c 4 -m 2G -d 10G                # creates 'test' with latest Ubuntu, 4 cores, 2 GB RAM and 10 GB disk
multipass launch bionic --name dev --cpus 2 --mem 2G --disk 20G
````
## List VMs
````powershell
multipass list
````

## Log files
````powershell
journalctl --unit snap.multipass*             # Linux
/Library/Logs/Multipass/multipassd.log        # macOS
````

## Enter VMs
````powershell
multipass shell primary
multipass shell <name>
multipass shell sharp-horntail
````

## Start, stop, suspend, delete VMs
````powershell
multipass start --all                 # start all VMs
multipass start sharp-horntail
multipass suspend sharp-horntail
multipass stop sharp-horntail        # stop the instance first
multipass delete sharp-horntail      # then delete it
multipass purge                      # purge all deleted instances permanently
````

## Run command on VM from outside
````powershell
multipass exec <name>  -- ifconfig
multipass exec sharp-horntail  -- ifconfig
````
