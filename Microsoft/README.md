# M i c r o s o f t

## Delete partition with PowerShell
Open PS as admin and run these commands. Remember to select apropriate partition.
````powershell
diskpart
list disk
select disk 0                   #i had only 1 disk
list partition
select partition 3              #i choose the Recovery Partition
delete partition override       #deleted it to extend the volume of the disk
````
