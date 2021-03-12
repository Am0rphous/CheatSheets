# Processess

````powershell
ps
ps auxw | grep nginx
pidof nginx
pgrep nginx
pgrep nginx | wc -l               # count number of processes
pidof nginx | wc -w               # count number of processes
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
