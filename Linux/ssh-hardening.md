
## SSH Hardening

- [OpenSSH](https://www.openssh.com)

## Setup and install
````
sudo apt-get install openssh-server                               # installs ssh server
sudo apt install fail2ban                                         # software to limit brute force authentication attempts
sudo systemctl enable sshd                                        # enable the service
sudo systemctl restart sshd                                       # restarts the service
sudo ufw allow ssh                                                # open port 22 in firewall
ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -b 4096 -t rsa   #created 4k bits key
````

## options you should change
````
#PermitRootLogin      Remove hashtag in front of the first letter
````


#### Check allowed ciphers, macs, and key algorithms

```
sshd -T | grep "\(ciphers\|macs\|kexalgorithms\)"
```

Example output:
```
chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
macs umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
kexalgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1
```

#### Check only ciphers

```
sshd -T | grep ciphers
```

#### List of secure ciphers
```
chacha20-poly1305@openssh.com
aes128-ctr
aes192-ctr
aes256-ctr
aes128-gcm@openssh.com
aes256-gcm@openssh.com
```

#### Check only Key Exchange Algorithms
```
sshd -T | grep kexalgorithms
```

#Example output:
curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1

#### Possible Insecure Key Exchange Algorithms
```
ecdh-sha2-nistp256          - Possible NSA backdoor
ecdh-sha2-nistp384          - Possible NSA backdoor
ecdh-sha2-nistp521          - Possible NSA backdoor
diffie-hellman-group14-sha1 - SHA-1 is becoming obsolete, consider using SHA-256 version
```

Server Host Key Algorithms
```
ecdsa-sha2-nistp256 - Possible NSA backdoor
```

MAC Algorithms
Check only MAC algorithms
```
sshd -T | grep macs
```

Example output
```
macs umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
```

#### Stay away from these:
```
umac-64-etm@openssh.com   - WEAK: 64-bit UMAC is no longer considered secure enough. Recommended tag size should be at least 128 bits.
hmac-sha1-etm@openssh.com - WEAK: SHA-1 is becoming deprecated - consider replacing with SHA-256 or SHA-512. 
umac-64@openssh.com       - WEAK: 64-bit UMAC is no longer considered secure enough. 
hmac-sha1                 - WEAK: SHA-1 is becoming deprecated - consider replacing with SHA-256 or SHA-512. 
```

edit: `nano /etc/ssh/sshd_config` to contain e.g.
```
ciphers chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
macs umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512
```

Restart SSH service
```
service sshd restart
```

