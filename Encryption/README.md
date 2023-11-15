# Encryption

- [CryptDecrypt](https://github.com/Va5c0/CryptDecrypt) - Encrypt your password or decrypt your hash. Multiple algorithms supported.
- [CryptHook](https://github.com/chokepoint/CryptHook) - TCP/UDP symmetric encryption tunnel wrapper.
- [CyberChef](https://gchq.github.io/CyberChef/)
- [Demiguise - HTA encryption tool](https://github.com/nccgroup/demiguise) - HTA encryption tool for RedTeams.

### GPG
````
gpg --encrypt -r recipient@example.com > tempfile
gpg --decrypt < tempfile
````

### OpenSSL
- Oneliner `sudo openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout 1.key -out 1.crt`
- [Useful openssl commands to view certificate content](https://www.golinuxcloud.com/openssl-view-certificate/)
- Verify certs:
````
openssl x509 -noout -text -in name.crt
openssl x509 -noout -text -in name.crt.chained
````

- Encryption Method one
````
openssl genrsa -out key.txt 2048                                    #Generate a 2048-bit RSA key and store it in key.txt
echo "Hello!" | openssl rsautl -inkey key.txt -encrypt > output.bin #Encrypt "Hello!" using the key
openssl rsautl -inkey key.txt -decrypt <output.bin                  #Decrypt the message
````
- Encryption Method two
````
#Generate a private/public key pair
openssl genrsa -out rsa_key.pri 2048; openssl rsa -in rsa_key.pri -out rsa_key.pub -outform PEM -pubout

#Encrypt the string using public key, and store in a file 
echo "stockexchange.com" | openssl rsautl -encrypt -inkey rsa_key.pub -pubin -out secret.dat

#Un-encrypt using private key
string=`openssl rsautl -decrypt -inkey rsa_key.pri -in secret.dat `; echo $string
stockexchange.com
````

## TLS
- [TLS Cipher String Cheat Sheet](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/TLS_Cipher_String_Cheat_Sheet.md)
