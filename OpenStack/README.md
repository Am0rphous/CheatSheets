# Open Stack

````
openstack -h | less
````


## Network

````
network create n1   #n1=network 1
subnet create s1 --network n1 --subnet-range 192.168.199.0/24       #s1=subnet 1
router create r1
router set r1 --external-gateway domain-internal
router add subnet r1 s1
````
- To delete it
````
openstack router remove subnet r1 s1
openstack router delete r1
openstack subnet delete s1
openstack network delete n1
``` 
- Create a server
````
openstack server create --image c9a2cd2d-bc9d-4b92-a2d9-1800be2ba594 --flavor l1.tiny --nic net-id=0f5e43fb-4f06-4f50-9040-fbf268abae2e --key-name MyKey u1

````





