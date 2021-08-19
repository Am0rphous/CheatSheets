# M i c r o s o f t

## Create and format hard disk partitions
````powershell
diskpart
list disk
select disk 1             #select approriate disk
clean                     #erases the selected disk
convert gpt
create part pri
format fs=exfat quick     #supports every os
assign
exit
````

## Delete a partition with PowerShell
Open PS as admin and run these commands. Remember to select apropriate partition.
````powershell
diskpart
list disk
select disk 0                   #i had only 1 disk
list partition
select partition 3              #i choose the Recovery Partition
delete partition override       #deleted it to extend the volume of the disk
````

## Display listening ports
````powershell
netstat -ano | Select-String LISTENING           #display TCP listening ports
````
