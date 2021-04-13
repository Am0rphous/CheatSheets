# Processess

### List and count processes
````powershell
ps                              # display currently active processes
ps auxw | grep nginx            # display processes from 'nginx'
pidof nginx 
pgrep nginx
pgrep nginx | wc -l               # count number of processes
pidof nginx | wc -w               # count number of processes
````
### Kill processes
````powershell
kill 1243               # kill process with pid id 1243
killall proc            # kill all processes named proc
````

### Monitor processes
````powershell
top
````
- [pSpy](https://github.com/DominicBreuker/pspy) - Monitor linux processes without root permissions

### Jobs
````powershell
bg                  # lists stopped background jobs; resume a stopped job in the background
fg                  # brings the most recent job to the foreground
fg n                # brings job 'n' to the foreground
````

### Zombie processes
````powershell
ps aux | grep 'Z'
ps axo pid=,stat= | awk '$2~/^Z/ { print }'
````
check [this later](https://askubuntu.com/questions/111422/how-to-find-zombie-process)

````
for pid in $(ps axo pid=,stat= | awk '$2~/^Z/ { print $1 }') ; do
    echo "$pid" # do something interesting here
done
````
