# Encoding & Decoding

### Base62
- [Base62](https://github.com/SiroDiaz/Base62) - PHP Base62 encoder and decoder for integers and big integers with Laravel 5 support.

### Base64
Encoding
````powershell
echo <string to encode> | base64
echo testuser:testpass | base64             # results in: dGVzdHVzZXI6dGVzdHBhc3MK
echo "ls -l |grep a" | base64               # results in: bHMgLWwgfGdyZXAgYQo=
base64 textfile.txt                         # encodes a file
base64 textfile.txt > newfile.txt           # encodes a file and saves output to a new file
````
Decoding
````powershell
echo <string to encode> | base64 -d
echo <string to encode> | base64 --decode
echo cGFzc3dvcmQ= | base64 -d                         # results in ''password
base64 -d textfile.txt                                # decodes a textfile which contains base64 encoding
````
