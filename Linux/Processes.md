# Processess

### List and count processes
````powershell
ps                              # display currently active processes
ps auxw | grep nginx            # display processes from 'nginx'
ps -fauxxx                      # check your system for associated orphaned processes
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
htop             # sudo apt install htop
glances          # sudo apt install glances
lsof -p $PID     # list open files and network streams
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
ps afuwwx | less +u -p'^(\S+\s+){7}Z.*'
ps axo pid=,stat= | awk '$2~/^Z/ { print }'
````
check [this later](https://askubuntu.com/questions/111422/how-to-find-zombie-process)

````
for pid in $(ps axo pid=,stat= | awk '$2~/^Z/ { print $1 }') ; do
    echo "$pid" # do something interesting here
done
````
