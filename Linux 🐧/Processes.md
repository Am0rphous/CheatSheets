# Processess

### List and count processes
````powershell
ps                              # display currently active processes
ps auxw | grep nginx            # display processes from 'nginx'
ps awwfux | less -S             # Display a scrollable process tree
ps -fauxxx                      # check your system for associated orphaned processes
ps -p 317738 -o comm=           # get name of process
pidof nginx 
pgrep nginx
pgrep nginx | wc -l             # count number of processes
pidof nginx | wc -w             # count number of processes
pstree                          # displays tree view 
````
### Kill processes
````powershell
kill 123               # kill process with pid id 1243 (SIGTERM, which is Gracefully. Can be handled, ignored and blocked. Does not kill child processes)
kill -9 123            # Kills immediately, cannot ble handled/blocked and kills chils processes as well
killall proc           # kill all processes named proc
````
Process stalling
````powershell
kill -SIGSTOP $PID      # stop a process without destroying its resources
kill -SIGCONT $PID      # resume a process previously stopped with SIGSTOP
````

### Monitor processes
````powershell
top
htop                                    # sudo apt install htop
glances                                 # sudo apt install glances
lsof -p $PID                            # list open files and network streams
tr '\0' '\n' < /proc/1179/environ       # list environment variables of a process separated by null bytes
ps aux | sort -nk +4 | tail             # display top 10 running processes - sorted by memory usage
````
- [pSpy](https://github.com/DominicBreuker/pspy) - Monitor linux processes without root permissions

### Jobs
````powershell
bg                  # lists stopped background jobs; resume a stopped job in the background
fg                  # brings the most recent job to the foreground
fg n                # brings job 'n' to the foreground
````

### Zombie processes
- [How to Find and Kill Zombie Process in Linux](https://itsfoss.com/kill-zombie-process-linux/) - "This is a quick tip on finding zombie processes in Linux and then killing them. You also learn a thing or two about processes and zombie processes."
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
