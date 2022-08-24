# Encryption

- [CryptDecrypt](https://github.com/Va5c0/CryptDecrypt) - Encrypt your password or decrypt your hash. Multiple algorithms supported.
- [CryptHook](https://github.com/chokepoint/CryptHook) - TCP/UDP symmetric encryption tunnel wrapper.
- [CyberChef](https://gchq.github.io/CyberChef/)
- [Demiguise - HTA encryption tool](https://github.com/nccgroup/demiguise) - HTA encryption tool for RedTeams.

### GPG
````
gpg --encrypt -r recipient@example.com >tempfile
gpg --decrypt <tempfile
````

### OpenSSL
- verifying
````
openssl x509 -noout -text -in nameCertificate.crt
openssl x509 -noout -text -in nameCertificate.crt.chained
````

- Encryption Method one
````
# generate a 2048-bit RSA key and store it in key.txt
openssl genrsa -out key.txt 2048

# encrypt "Hello world!" using the RSA key (key.txt)
echo "Hello world!" | openssl rsautl -inkey key.txt -encrypt >output.bin

# decrypt the message and output to stdout
openssl rsautl -inkey key.txt -decrypt <output.bin
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
