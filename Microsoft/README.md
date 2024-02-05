# Windows

- windows+R opens the old Control Panel where you can install/uninstall software

<details> <summary> <h3>Create and format hard disk partitions (Expand)</h3></summary> <br>
  
  Open Powershell and run following as Administrator
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
</details>

<details> <summary> <h3> Delete a partition with PowerShell (Expand)</h3></summary> <br>
  
Open PS as admin and run these commands. Remember to select apropriate partition.
  ````powershell
diskpart
list disk
select disk 0                   #i had only 1 disk
list partition
select partition 3              #i choose the Recovery Partition
delete partition override       #deleted it to extend the volume of the disk
  ````
</details>

<details> <summary> <h3> Display listening ports (Expand)</h3></summary> <br>
Open PS as admin and run these commands. Remember to select apropriate partition.
  ````powershell
netstat -ano | Select-String LISTENING           #display TCP listening ports
  ````
</details>


<details> <summary> <h3>Repair a corrupt system (Expand)</h3></summary> <br>
  
_"If some Windows functions aren't working or Windows crashes, use the System File Checker to scan Windows and restore your files."_ [source](https://support.microsoft.com/en-us/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e)

  Open Powershell and run following as Administrator
  ````powershell
  sfc /scannow
  ````
</details>
